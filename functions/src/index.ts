import { AuthUser } from "./AuthUser";
import * as functions from "firebase-functions";
const admin = require("firebase-admin");
admin.initializeApp();
import Email = require("./email");
const draw = require("./draw");
//const bodyParser = require("body-parser");
import * as dotenv from "dotenv";
dotenv.config();
const db = admin.firestore();
//const cors = require("cors")({ origin: true });
const axios = require("axios").default;
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
  .onCreate((snap, context) => {
    const activity: FirebaseFirestore.DocumentData = snap.data();

    console.log("new provider requested" + activity.name);
    console.log("new provider requested");
  });

export const onUserCheckIn = functions
  .region("europe-west3")
  .firestore.document("providers/{providerId}/events/{eventId}/users/{userId}")
  .onCreate(async (snap, context) => {
    try {
      const eventId = context.params.eventId;
      const providerId = context.params.providerId;
      const userId = context.params.userId;

      const s = snap;
      const user: FirebaseFirestore.DocumentData = s.data();
      console.log("user check in name: " + user.name + " " + user.id);

      if (user.id === undefined || user.id === null) {
        console.log("user id undefined ");
        return null;
      }

      const providerDoc: FirebaseFirestore.DocumentData = await db
        .collection("providers")
        .doc(providerId)
        .get();

      if (!providerDoc.data().releaseWom) {
        console.log("this provider not release wom to user : " + userId);
        return;
      }
      const id = user.id;
      const userDoc: FirebaseFirestore.DocumentData = await db
        .collection("users")
        .doc(id)
        .get();
      const userData = userDoc.data();
      const email = userData.email;
      //console.log(userData);
      if (email === undefined || email === null) {
        console.log("STOP user not exist email undefined ");
        return null;
      }

      console.log("user exist email " + userData.email);
      const eventDoc: FirebaseFirestore.DocumentData = await db
        .collection("providers")
        .doc(providerId)
        .collection("events")
        .doc(eventId)
        .get();

      const eventName = eventDoc.data().name;
      console.log(eventName);
      const womCount = eventDoc.data().womCount;
      if (womCount === undefined || womCount === null || womCount == 0) {
        console.log("STOP wom count is " + womCount);
        return;
      }
      const apiKey = providerDoc.data().apiKey;
      const aim = providerDoc.data().aim;
      const data = {
        apiKey: apiKey,
        womCount: womCount,
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
        womCount,
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
      const role = data.role;
      const fullName = name + " " + surname;

      if (email === undefined || email === null || email === "") {
        response.status(400).send("invalid userId");
        return;
      }

      try {
        const user = await admin.auth().createUser({
          email: email,
          emailVerified: true,
          password: "123456",
          displayName: fullName,
        });
        console.log("user created " + user.uid);

        const authUser = new AuthUser(
          user.uid,
          name,
          surname,
          email,
          user.emailVerified,
          role
        );

        //await admin.auth().setCustomUserClaims(user.uid, {
        //  role: role,
        //});
        await db.doc("credentials" + "/" + user.uid).set(authUser.toJson());
        await generateAndSendResetPasswordEmail(fullName, email);
        response.status(200).end();
      } catch (error) {
        console.log(error);
        response.status(500).send(error);
      }
    }
  );

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

export const createNewActivity = functions
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
      //const releaseWom = data.releaseWom;
      //const status = data.status;

      if (name === undefined || name === null || name === "") {
        response.status(400).send("invalid name");
        return;
      }

      try {
        /*const data = {
          acceptPassepartout: acceptPassepartout,
          name: name,
          releaseWom: releaseWom,
        };*/
        await db.collection("providers").doc().set(data);
        response.status(200).end();
      } catch (error) {
        console.log(error);
        response.status(500).send(error);
      }
    }
  );

//TODO Remove in live
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

/*
export const moveUrbino = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      const activity = await db
        .collection("providers")
        .doc("wom-count-me-in")
        .get();

      await db.collection("providers").doc("countmein").set(activity.data());
    }
  );
*/
