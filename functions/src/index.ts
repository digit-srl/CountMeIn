import * as functions from "firebase-functions";
const admin = require("firebase-admin");
admin.initializeApp();
import Email = require("./email");
const draw = require("./draw");
//const bodyParser = require("body-parser");
import * as dotenv from "dotenv";
dotenv.config();
const db = admin.firestore();
const axios = require("axios").default;
const cors = require("cors")({ origin: true });
import { FirebaseError } from "@firebase/util";
import { UserRecord } from "firebase-functions/v1/auth";
import * as firestore from "@google-cloud/firestore";
//import "@firebase/firestore";

/*
export const drawCard = functions.region('europe-west3').https.onRequest((request, response) => {
  const a = new AuthUser("", "", "", "", [], true);
  console.log(a);

  const fullName = "Gian Marco Di Francesco";
  const cf = "Gian Marco Di Francesco";
  const email = "difrancescogianmarco@gmail.com";
  const activityName = "Urbino on foot";
  const url = "Urbino on foot";

  Email.sendEmail([""], "", "", "", null);
  return draw
    .drawUserCard(activityName, fullName, cf, email, url)
    .then((buffer: Buffer) => {
      return null;
    })
    .catch((err: any) => {
      throw new functions.https.HttpsError("unknown", err);
    });
});
*/

/*
export const onAuthCreate = functions
  .region("europe-west3")
  .auth.user()
  .onCreate((user) => {
    const email = user.email;
    const uid = user.uid;

    const authUser = new AuthUser(
      uid,
      "",
      "",
      email ?? "",
      [],
      user.emailVerified
    );
    db.doc("credentials" + "/" + uid).set(authUser.toJson());
  });
*/

export const onActivityRequested = functions
  .region("europe-west3")
  .firestore.document("providerRequests/{docId}")
  .onCreate(async (snap, context) => {
    const provider: FirebaseFirestore.DocumentData = snap.data();
    const adminFullName = provider.adminName + " " + provider.adminSurname;
    console.log(
      "new provider requested" +
        adminFullName +
        " " +
        provider.name +
        " " +
        provider.adminEmail
    );

    const link = "https://cmi.digit.srl/adminPendingProviders";

    await Email.sendNewActivityRequestedToUser(
      provider.name,
      provider.adminEmail,
      adminFullName
    );
    return Email.sendNewActivityRequested(
      provider.name,
      provider.adminEmail,
      adminFullName,
      link
    );
  });

export const onActivityRequestedUpdated = functions
  .region("europe-west3")
  .firestore.document("providerRequests/{docId}")
  .onUpdate(async (change, context) => {
    // Get an object representing the document
    // e.g. {'name': 'Marie', 'age': 66}
    const provider: FirebaseFirestore.DocumentData = change.after.data();
    const previousProvider: FirebaseFirestore.DocumentData =
      change.before.data();

    if (previousProvider.status === "pending" && provider.status === "live") {
      const providerId = provider.id;
      const email = provider.adminEmail;
      const surname = provider.adminSurname;
      const name = provider.adminName;
      const cf = provider.adminCf;
      const fullName = name + " " + surname;

      console.log(
        "new provider created" + name + " " + provider.name + " " + email
      );

      let user: UserRecord | undefined;
      try {
        user = await admin.auth().getUserByEmail(email);
        console.log("user exist");
      } catch (err) {
        console.log(err);
        if (err instanceof FirebaseError) {
          console.error(err.code);
          if (err.code === "auth/user-not-found") {
            console.log("User doesn't exist yet, create it...");
            user = await createNewAdminForProvider(
              name,
              surname,
              email,
              "admin",
              providerId,
              cf
            );
          }
        }
      }

      if (user === undefined || user === null) {
        throw new functions.https.HttpsError(
          "aborted",
          "user not exist or creation failed"
        );
      }
      const requestId = context.params.docId;

      let map = {
        id: user.uid,
        role: "admin",
        email: email,
        name: fullName,
      };
      let managers = new Map<string, Object>();
      managers.set("managers." + user.uid, map);
      let jManagers = Object.fromEntries(managers);

      await db.collection("providers").doc(requestId).set(provider);
      await db.collection("providers").doc(requestId).update(jManagers);
      await Email.sendWelcomeNewProvider(
        provider.name,
        email,
        fullName,
        "admin"
      );
    }
  });

/*
export const onActivityCreated = functions
  .region("europe-west3")
  .firestore.document("providers/{docId}")
  .onCreate(async (snap, context) => {
    const provider: FirebaseFirestore.DocumentData = snap.data();

    const providerId = provider.id;
    const email = provider.adminEmail;
    const surname = provider.adminSurname;
    const name = provider.adminName;
    const cf = provider.adminCf;
    const fullName = name + " " + surname;

    console.log(
      "new provider created" + name + " " + provider.name + " " + email
    );

    await createNewAdminForProvider(
      name,
      surname,
      email,
      "admin",
      providerId,
      cf
    );
    await Email.sendWelcomeNewProvider(provider.name, email, fullName, "admin");
  });*/

export const onUserCheckIn = functions
  .region("europe-west3")
  .firestore.document(
    "providers/{providerId}/events/{eventId}/subEvents/{subEventId}/users/{userId}"
  )
  .onWrite(async (snap, context) => {
    try {
      const eventId = context.params.eventId;
      const providerId = context.params.providerId;
      const userId = context.params.userId;

      //utente cancellato
      if (!snap.after.exists) {
        console.log("utente rimosso da " + "eventId: " + userId);
        return;
      }

      const eventDoc: FirebaseFirestore.DocumentData = await db
        .collection("providers")
        .doc(providerId)
        .collection("events")
        .doc(eventId)
        .get();

      const event = eventDoc.data();
      const womCount = event.maxWomCount;
      const eventName = event.name;
      const eventAccessType = event.accessType;
      console.log(eventName);

      if (womCount === undefined || womCount === null || womCount === 0) {
        console.log("this event not release wom to user : " + userId);
        return;
      }

      const user: FirebaseFirestore.DocumentData | undefined =
        snap.after.data();
      console.log("user check in name: " + user?.name + " " + user?.id);

      if (user === undefined || user === null) {
        console.log("user id undefined ");
        return null;
      }

      const checkOutAt = user.checkOutAt;
      const checkInAt = user.checkInAt;

      if (checkOutAt === undefined || checkOutAt === null) {
        console.log("Missing checkOut");
        return null;
      }

      /*const providerDoc: FirebaseFirestore.DocumentData = await db
        .collection("providers")
        .doc(providerId)
        .get();

      if (!providerDoc.data().releaseWom) {
        console.log("this provider not release wom to user : " + userId);
        return;
      }*/

      const userDoc: FirebaseFirestore.DocumentData = await db
        .collection("users")
        .doc(userId)
        .get();

      const userData = userDoc.data();
      const email = userData.email;
      //console.log(userData);

      if (email === undefined || email === null) {
        console.log("STOP user not exist email undefined ");
        return null;
      }

      console.log("user exist email " + userData.email);

      const providerDoc: FirebaseFirestore.DocumentData = await db
        .collection("providers")
        .doc(providerId)
        .get();

      let wom = womCount;

      if (eventAccessType === "inOut") {
        if (checkInAt === undefined || checkInAt === null) {
          console.log("ChekInAt is undefined or null");
          return null;
        }

        const checkOuDate = checkOutAt.toDate();
        const checkInDate = checkInAt.toDate();

        let diffMs = checkOuDate - checkInDate; // milliseconds
        let diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000); // minutes
        console.log(diffMins + "minutes");
        const tmpWom = diffMins;
        const minWom = Math.min(wom, tmpWom);
        wom = minWom;
      }

      const apiKey = providerDoc.data().apiKey;
      const aim = providerDoc.data().aim;

      if (apiKey === undefined || apiKey === null) {
        console.log("ApiKey is null or undefined, providerId: " + providerId);
        return null;
      }
      const data = {
        apiKey: apiKey,
        womCount: wom,
        lat: 0.0,
        long: 0.0,
        aim: aim,
      };
      console.log(data);

      const headers = {
        "X-SuperSecret-Key": process.env.SECRET_HEADER_KEY,
      };

      const response = await axios.post(
        process.env.WOM_SERVICE_DOMAIN + "/vouchers",
        data,
        {
          headers: headers,
        }
      );
      console.log(response.status);
      const link = response.data.womLink;
      const pin = response.data.womPassword;

      const providerName = providerDoc.data().name;
      return Email.sendWomEmail(
        link,
        wom,
        email,
        pin,
        user.name,
        providerName,
        eventName
      );
    } catch (ex) {
      console.log("onUpdateCheckIn failed");
      console.log(ex);
      return null;
    }
  });

export const onUserCreated = functions
  .region("europe-west3")
  .firestore.document("users/{docId}")
  .onCreate((snap, context) => {
    const user: FirebaseFirestore.DocumentData = snap.data();

    console.log("new user crated " + user.email);

    const fullName = user.name + " " + user.surname;
    return Email.sendVerificationEmail(
      fullName,
      user.email,
      user.id,
      user.secret
    );
  });

export const onUserVerificationDone = functions
  .region("europe-west3")
  .firestore.document("users/{userId}")
  .onUpdate((change, context) => {
    // Get an object representing the document
    // e.g. {'name': 'Marie', 'age': 66}
    const user: FirebaseFirestore.DocumentData = change.after.data();
    const secret = user.secret;
    const providerName = user.providerName;
    const providerId = user.providerName;
    const emailVerified = user.emailVerified;

    // ...or the previous value before this update
    const previousValue = change.before.data();
    const previousEmailVerified = previousValue.emailVerified;

    if (secret === undefined || secret === null) {
      if (
        previousEmailVerified == false &&
        emailVerified === true &&
        providerName !== null &&
        providerId !== null
      ) {
        return sendUserCard(user)
          .then(() => {
            console.log("send user card complete");
            db.collection("users").doc(user.id).update({
              providerId: null,
              providerName: null,
            });
            return null;
          })
          .catch((err: any) => {
            console.log(err);
            throw new functions.https.HttpsError("aborted", err);
          });
      } else if (
        previousEmailVerified == true &&
        emailVerified == true &&
        providerName !== null &&
        providerId !== null
      ) {
        console.log(
          "user already registered, this is a new subscriber for other provider"
        );
        return sendUserCard(user)
          .then(() => {
            console.log("send user card complete");
            db.collection("users").doc(user.id).update({
              providerId: null,
              providerName: null,
            });
            return null;
          })
          .catch((err: any) => {
            console.log(err);
            throw new functions.https.HttpsError("aborted", err);
          });
      }
    }
    return null;
  });

async function sendUserCard(data: FirebaseFirestore.DocumentData) {
  const userId = data.id;
  const name = data.name;
  const surname = data.surname;
  const fullName = name + " " + surname;
  const cf = data.cf;
  const email = data.email;
  const activityName = data.providerName;
  const activityId = data.providerId;
  const url =
    "https://cmi.digit.srl/profile/" +
    userId +
    "?" +
    "name=" +
    name +
    "&surname=" +
    surname +
    "&cf=" +
    cf +
    "&pId=" +
    activityId;
  //"&email=" +
  //email;

  const buffer = await draw.drawUserCard(
    activityName,
    name,
    surname,
    cf,
    email,
    url
  );
  return Email.sendUserCardEmail(fullName, email, cf, buffer, activityName)
    .then(() => {
      return true;
    })
    .catch((err: any) => {
      console.log(err);
      throw new functions.https.HttpsError("aborted", err);
    });
}

export const changeClaim = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      console.log(request.body);

      if (request.method !== "POST") {
        response.status(403).send("Forbidden!");
        return;
      }

      const data = request.body;
      const userId = data.userId;
      const role = data.role;

      if (userId === undefined || userId === null || userId === "") {
        response.status(400).send("invalid userId");
        return;
      }

      try {
        // Set custom user claims on this newly created user.
        await admin.auth().setCustomUserClaims(userId, {
          role: role,
        });

        // Update real-time database to notify client to force refresh.
        const metadataRef = db.collection("metadata").doc(userId);

        // Set the refresh time to the current UTC timestamp.
        // This will be captured on the client to force a token refresh.
        await metadataRef.set({ refreshTime: new Date().getTime() });
        response.status(200).end();
      } catch (error) {
        console.log(error);
      }
    }
  );

export const sendResetPasswordEmail = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      console.log(request.body);

      if (request.method !== "POST") {
        response.status(403).send("Forbidden!");
        return;
      }

      const data = request.body;
      const userEmail = data.email;
      const fullName = data.fullName;

      if (userEmail === undefined || userEmail === null || userEmail === "") {
        response.status(400).send("invalid userId");
        return;
      }

      return generateAndSendResetPasswordEmail(fullName, userEmail)
        .then(() => {
          response.status(200).end();
        })
        .catch((error: any) => {
          console.log(error);
          response.status(500).send(error);
        });
      /*    return admin
        .auth()
        .generatePasswordResetLink(userEmail)
        .then((link: string) => {
          console.log(link);

          let paramString = link.split("?")[1];
          let queryString = new URLSearchParams(paramString);

          for (let pair of queryString.entries()) {
            console.log("Key is: " + pair[0]);
            console.log("Value is: " + pair[1]);
          }

          const oobCode = queryString.get("oobCode");
          console.log("oobCode => " + oobCode);
          if (oobCode === undefined || oobCode === null) {
            response.status(500).send("Missing oobCode in generated link");
            return;
          }
          Email.sendResetPasswordEmail(fullName, userEmail, oobCode).then(
            () => {
              response.status(200).end();
            }
          );
        })
        .catch((error: any) => {
          console.log(error);
          response.status(500).send(error);
        });*/
    }
  );

// Only for testing
export const crateNewUser = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      console.log(request.body);

      if (request.method !== "POST") {
        response.status(403).send("Forbidden!");
        return;
      }

      const data = request.body;
      const email = data.email;
      const name = data.name;
      const surname = data.surname;
      //const providerId = data.providerId;

      if (email === undefined || email === null || email === "") {
        response.status(400).send("invalid userId");
        return;
      }

      try {
        await createNewAdminForProvider(
          name,
          surname,
          email,
          "admin",
          "",
          "DFRGMR89M02i348U"
        );
        response.status(200).end();
      } catch (error) {
        console.log(error);
        response.status(500).send(error);
      }
    }
  );

async function createNewAdminForProvider(
  name: string,
  surname: string,
  email: string,
  role: string,
  providerId: string,
  cf: string
): Promise<UserRecord> {
  const fullName = name + " " + surname;
  const user = await admin.auth().createUser({
    email: email,
    emailVerified: true,
    password: "123456",
    displayName: fullName,
  });
  console.log("user created " + user.uid);

  let map = new Map<string, string>();
  map.set(providerId, role);

  let jsonObject = Object.fromEntries(map);

  //await admin.auth().setCustomUserClaims(user.uid, {
  //  role: role,
  //});
  await db.doc("credentials" + "/" + user.uid).set({
    uid: user.uid,
    surname: surname,
    name: name,
    email: email,
    emailVerified: user.emailVerified,
    providersRole: jsonObject,
    cf: cf,
  });
  //await generateAndSendResetPasswordEmail(fullName, email);
  return user;
}

async function generateAndSendResetPasswordEmail(
  fullName: string,
  userEmail: string
) {
  try {
    const link = await admin.auth().generatePasswordResetLink(userEmail);

    console.log(link);

    let paramString = link.split("?")[1];
    let queryString = new URLSearchParams(paramString);

    for (let pair of queryString.entries()) {
      console.log("Key is: " + pair[0]);
      console.log("Value is: " + pair[1]);
    }

    const oobCode = queryString.get("oobCode");
    console.log("oobCode => " + oobCode);
    if (oobCode === undefined || oobCode === null) {
      throw Error();
    }
    await Email.sendResetPasswordEmail(fullName, userEmail, oobCode);
  } catch (ex) {
    throw ex;
  }
}

//Only for testing
export const createNewProvider = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      console.log(request.body);

      if (request.method !== "POST") {
        response.status(403).send("Forbidden!");
        return;
      }

      const data = request.body;
      //const acceptPassepartout = data.acceptPassepartout;
      const name = data.name;
      const surname = data.surname;
      const email = data.email;
      //const releaseWom = data.releaseWom;
      //const status = data.status;

      if (name === undefined || name === null || name === "") {
        response.status(400).send("invalid name");
        return;
      }

      try {
        await createNewAdminForProvider(
          name,
          surname,
          email,
          "admin",
          "",
          "DFRGMR89M02I348U"
        );
        response.status(200).end();
      } catch (error) {
        console.log(error);
        response.status(500).send(error);
      }
    }
  );

//Only for testing
export const verifyEmail = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      console.log(request.body);

      if (request.method !== "POST") {
        response.status(403).send("Forbidden!");
        return;
      }

      const data = request.body;
      const email = data.email;
      const uid = data.uid;

      if (email === undefined || email === null || email === "") {
        response.status(400).send("invalid email");
        return;
      }

      try {
        await admin.auth().updateUser(uid, {
          emailVerified: true,
        });
        response.status(200).end();
      } catch (error) {
        console.log(error);
        response.status(500).send(error);
      }
    }
  );

// Saves a message to the Firebase Realtime Database but sanitizes the text by removing swearwords.
export const confirmPendingInvite = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }

        const data = request.body;
        console.log("confirmPendingInvite");
        const inviteId: string = data.inviteId;
        const secret = data.secret;
        const providerId: string = data.providerId;

        if (
          inviteId === undefined ||
          inviteId === null ||
          providerId === undefined ||
          providerId === null ||
          secret === undefined ||
          secret === null
        ) {
          throw new functions.https.HttpsError(
            "invalid-argument",
            "inviteId: " +
              inviteId +
              " secret: " +
              secret +
              " providerId: " +
              providerId
          );
        }

        console.log("confirmPendingInvite: arguments ok");
        const invite = await db
          .collection("providers")
          .doc(providerId)
          .collection("pendingInvite")
          .doc(inviteId)
          .get();

        const inviteData = invite.data();
        const status = inviteData.status;
        if (status === "completed") {
          response
            .send({
              status: "alreadyConfirmed",
            })
            .end();
          return;
        } else if (status === "deleted") {
          response
            .send({
              status: "deletedFromOwner",
            })
            .end();
          return;
        }

        const secretOnDb = inviteData.secret;
        const email = inviteData.email;
        var fullName = inviteData.fullName;
        console.log(inviteData);

        const role: string = inviteData.role;

        if (secretOnDb !== secret) {
          console.log("invite secret: " + secretOnDb + " != " + secret);
          throw new functions.https.HttpsError(
            "permission-denied",
            "The secret is different!"
          );
        }

        console.log("confirmPendingInvite: secret ok");
        var userId = inviteData.userId;
        const name = data.name;
        const surname = data.surname;
        const cf = data.cf;

        // New user
        if (userId === undefined || userId === null) {
          console.log("confirmPendingInvite: new user");
          if (
            name === undefined ||
            name === null ||
            surname === undefined ||
            surname === null ||
            cf === undefined ||
            cf === null
          ) {
            throw new functions.https.HttpsError(
              "invalid-argument",
              "name: " + name + " surname: " + surname + " cf: " + cf
            );
          }
          fullName = name + " " + surname;

          userId = await createNewAdminForProvider(
            name,
            surname,
            email,
            role,
            providerId,
            cf
          );
        }

        //TODO  controlla che l utente esista veramente

        let map = {
          id: userId,
          role: role,
          email: email,
          name: fullName,
        };
        let managers = new Map<string, Object>();
        managers.set("managers." + userId, map);
        let jManagers = Object.fromEntries(managers);

        console.log("updating managers");

        console.log(jManagers);

        await db.doc("providers" + "/" + providerId).update(jManagers);
        await db
          .collection("providers")
          .doc(providerId)
          .collection("pendingInvite")
          .doc(inviteId)
          .update({
            status: "completed",
          });
        await Email.sendWelcomeNewProvider(
          inviteData.providerName,
          email,
          fullName,
          role
        );
        response
          .send({
            status: "completed",
          })
          .end();

        //let map = new Map<string, string>();
        //map.set("providersRole." + invite.userId, role);
        //let jsonObject = Object.fromEntries(map);

        /*return db
        .doc("credentials" + "/" + invite.userId)
        .update(jsonObject)
        .then(() => {
          return {
            status: "completed",
          };
        });*/
      });
    }
  );

/*
export const checkIn = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      db.collection("providers")
        .doc("Yy31B32YBDJDUt7TbZEl")
        .collection("events")
        .doc("7aa0445a-517f-44c9-96bb-d982b2a9be28")
        .collection("subEvents")
        .doc("2022-08-09")
        .collection("users")
        .doc(request.body.id)
        .update(request.body);

      //await db.collection("providers").doc("countmein").set(activity.data());
    }
  );

  */
export const onInviteToCollaborate = functions
  .region("europe-west3")
  .firestore.document("providers/{providerId}/pendingInvite/{inviteId}")
  .onCreate(async (snap, context) => {
    const inviteId = context.params.inviteId;
    const providerId = context.params.providerId;
    const invite: FirebaseFirestore.DocumentData = snap.data();

    const role = invite.role;
    const email = invite.email;
    const providerName = invite.providerName;
    const fullName = invite.name;
    console.log(
      "new invite to collaborate " +
        providerName +
        " " +
        fullName +
        " " +
        role +
        " " +
        email
    );

    // TODO check that all field is valid

    const requestRef = db
      .collection("providers")
      .doc(providerId)
      .collection("pendingInvite")
      .doc(inviteId);
    var secret = Math.random().toString(36).slice(-8);

    await requestRef.update({
      secret: secret,
    });

    var url: string =
      "https://cmi.digit.srl/confirmInvite?i=" +
      inviteId +
      "&s=" +
      secret +
      "&p=" +
      providerId +
      "&n=" +
      providerName;

    try {
      const user = await admin.auth().getUserByEmail(email);
      await requestRef.update({
        userId: user.uid,
        fullName: user.displayName,
      });
      url = url + "&u=" + user.uid;
      console.log("user exist");
    } catch (err) {
      console.log(err);
      //if (err.code === "auth/user-not-found") {
      // User doesn't exist yet, create it...
      // }
    }

    console.log(url);
    return Email.sendInvite(providerName, fullName, email, role, url);
  });
/*
export const processEvents = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      const now = new Date();
      console.log(
        "This will be run every day at 00:00 UTC " + now.toISOString()
      );

      const nowUTC = dateToUTC(new Date());
      console.log(nowUTC);
      //prendo tutti gli eventi attivi ricorrenti che sono da aggiornare (query su subEventDeadline)
      const querySnapshot = await db
        .collectionGroup("events")
        .where("status", "==", "live")
        //.where("recurring", "==", true)
        .where("subEventDeadline", "<=", nowUTC)
        .get();

      querySnapshot.forEach(
        async (doc: FirebaseFirestore.QueryDocumentSnapshot) => {
          console.log(doc.id, " => ", doc.data());

          const docRef = doc.ref;
          const providerId = docRef.parent.parent?.id;

          console.log("providerId:" + providerId);

          const data = doc.data();
          const recurrence = data.recurrence;
          const remaining = data.remaining;

          if (remaining > 0) {
            var multiplier = 1;
            if (recurrence === "daily") {
              multiplier = 1;
            } else if (recurrence === "monthly") {
              multiplier = 31;
            } else if (recurrence === "yearly") {
              multiplier = 365;
            }

            const subEventDeadlineTimestamp: FirebaseFirestore.Timestamp =
              data.subEventDeadline;
            const subEventDeadlineDate = subEventDeadlineTimestamp.toDate();

            let nextSubEventDeadlineDate: Date = addDays(
              multiplier,
              subEventDeadlineDate
            );

            console.log(subEventDeadlineDate);
            console.log(nextSubEventDeadlineDate);

            const nextSubEventId =
              nextSubEventDeadlineDate.getFullYear() +
              "-" +
              ("0" + (nextSubEventDeadlineDate.getMonth() + 1)).slice(-2) +
              "-" +
              ("0" + nextSubEventDeadlineDate.getDate()).slice(-2);

            console.log("nextSubEventId " + nextSubEventId);

            const nextReimaining = remaining - 1;

            const nextSubEventDeadlineTimestamp: firestore.Timestamp =
              firestore.Timestamp.fromDate(nextSubEventDeadlineDate);

            const nextSubEvent = {
              id: nextSubEventId,
              startAt: subEventDeadlineTimestamp,
              endAt: nextSubEventDeadlineTimestamp,
            };

            await docRef.update({
              remaining: nextReimaining,
              currentSubEvent: nextSubEventId,
              subEventDeadline: nextSubEventDeadlineTimestamp,
            });

            await docRef
              .collection("subEvents")
              .doc(nextSubEventId)
              .set(nextSubEvent);
          } else {
            //chiudo l evento
            await docRef.update({
              subEventDeadline: null,
              status: "closed",
            });
          }
        }
      );
      response.status(200).send("There are " + querySnapshot.size + " events");
    }
  );
  */

function addDays(numOfDays: number, date = new Date()) {
  const dateCopy = new Date(date.getTime());

  dateCopy.setDate(dateCopy.getDate() + numOfDays);

  return dateCopy;
}

function dateToUTC(date: Date) {
  const utcDate = new Date(date.toUTCString().slice(0, -4));
  return utcDate;
}

export const updateSubEventsCron = functions
  .region("europe-west3")
  //.pubsub.schedule("*/30 * * * *")
  .pubsub.schedule("0 0 * * *")
  .timeZone("Etc/UTC")
  .onRun(async (_) => {
    const now = new Date();
    console.log("This will be run every day at 00:00 UTC " + now.toISOString());

    const nowUTC = dateToUTC(new Date());
    console.log(nowUTC);
    //prendo tutti gli eventi attivi ricorrenti che sono da aggiornare (query su subEventDeadline)
    const querySnapshot = await db
      .collectionGroup("events")
      .where("status", "==", "live")
      //.where("recurring", "==", true)
      .where("subEventDeadline", "<=", nowUTC)
      .get();

    querySnapshot.forEach(
      async (doc: FirebaseFirestore.QueryDocumentSnapshot) => {
        console.log(doc.id, " => ", doc.data());

        const docRef = doc.ref;
        const providerId = docRef.parent.parent?.id;

        console.log("providerId:" + providerId);

        const data = doc.data();
        const recurrence = data.recurrence;
        const remaining = data.remaining;

        if (remaining > 0) {
          var multiplier = 1;
          if (recurrence === "daily") {
            multiplier = 1;
          } else if (recurrence === "monthly") {
            multiplier = 31;
          } else if (recurrence === "yearly") {
            multiplier = 365;
          }

          const subEventDeadlineTimestamp: FirebaseFirestore.Timestamp =
            data.subEventDeadline;
          const subEventDeadlineDate = subEventDeadlineTimestamp.toDate();

          let nextSubEventDeadlineDate: Date = addDays(
            multiplier,
            subEventDeadlineDate
          );

          console.log(subEventDeadlineDate);
          console.log(nextSubEventDeadlineDate);

          const nextSubEventId =
            nextSubEventDeadlineDate.getFullYear() +
            "-" +
            ("0" + (nextSubEventDeadlineDate.getMonth() + 1)).slice(-2) +
            "-" +
            ("0" + nextSubEventDeadlineDate.getDate()).slice(-2);

          console.log("nextSubEventId " + nextSubEventId);

          const nextReimaining = remaining - 1;

          const nextSubEventDeadlineTimestamp: firestore.Timestamp =
            firestore.Timestamp.fromDate(nextSubEventDeadlineDate);

          const nextSubEvent = {
            id: nextSubEventId,
            startAt: subEventDeadlineTimestamp,
            endAt: nextSubEventDeadlineTimestamp,
          };

          await docRef.update({
            remaining: nextReimaining,
            currentSubEvent: nextSubEventId,
            subEventDeadline: nextSubEventDeadlineTimestamp,
          });

          await docRef
            .collection("subEvents")
            .doc(nextSubEventId)
            .set(nextSubEvent);
        } else {
          //chiudo l evento
          await docRef.update({
            subEventDeadline: null,
            status: "closed",
          });
        }
      }
    );
  });
