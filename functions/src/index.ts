import * as functions from "firebase-functions";
const admin = require("firebase-admin");
admin.initializeApp();
import * as dotenv from "dotenv";
dotenv.config();
const db = admin.firestore();
import { dateToUTC, addDays } from "./utils";
import * as firestore from "@google-cloud/firestore";

exports.userProfile = require("./user_profile");
exports.userCheckIn = require("./user_check_in");
exports.userSignUp = require("./user_sign_up");
exports.scanner = require("./scan_processing");
exports.events = require("./events");
exports.managers = require("./provider_managers");
exports.activity = require("./activities");
exports.embedded = require("./embedded_qr_code");

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

/*
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
*/

/*
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
*/

export const updateSubEventsCron = functions
  .region("europe-west3")
  .pubsub.schedule("*/30 * * * *")
  //.pubsub.schedule("0 0 * * *")
  .timeZone("Etc/UTC")
  .onRun(async (_) => {
    return updateSubEvent();
  });

async function updateSubEvent(): Promise<void> {
  const now = new Date();
  console.log("This will be run every 30 minutes" + now.toISOString());

  var nowUTC = dateToUTC(new Date());

  // For Test
  //nowUTC = dateToUTC(new Date(2023, 7, 18, 3));
  console.log(nowUTC);

  //prendo tutti gli eventi attivi ricorrenti che sono da aggiornare (query su subEventDeadline)
  const querySnapshot = await db
    .collectionGroup("events")
    .where("status", "==", "live")
    //.where("recurring", "==", true)
    .where("type", "==", "periodic")
    .where("subEventDeadline", "<=", nowUTC)
    .get();

  querySnapshot.forEach(
    async (doc: FirebaseFirestore.QueryDocumentSnapshot) => {
      console.log(doc.id, " => ", doc.data());

      const docRef = doc.ref;
      const providerId = docRef.parent.parent?.id;

      console.log("providerId:" + providerId);

      const data = doc.data();
      const frequency = data.frequency;
      const remaining = data.remaining;

      if (remaining > 0) {
        var multiplier = 1;
        if (frequency === "daily") {
          multiplier = 1;
        } else if (frequency === "weekly") {
          multiplier = 7;
        }

        console.log("multiplier is: " + multiplier);

        // Data di fine sessione
        const subEventDeadlineTimestamp: FirebaseFirestore.Timestamp =
          data.subEventDeadline;
        const subEventDeadlineDate = subEventDeadlineTimestamp.toDate();

        // Date evento corrente
        const currentSubEventDate = addDays(-1, subEventDeadlineDate);
        console.log("currentSubEventDate " + currentSubEventDate);
        const nextSubEventDate = addDays(multiplier, currentSubEventDate);
        console.log("nextSubEventDate " + nextSubEventDate);

        // Prossima data di fine sessione
        let nextSubEventDeadlineDate: Date = addDays(
          multiplier,
          subEventDeadlineDate
        );

        console.log(subEventDeadlineDate);
        console.log(nextSubEventDeadlineDate);

        const nextSubEventId =
          nextSubEventDate.getFullYear() +
          "-" +
          ("0" + (nextSubEventDate.getMonth() + 1)).slice(-2) +
          "-" +
          ("0" + nextSubEventDate.getDate()).slice(-2);

        console.log("nextSubEventId " + nextSubEventId);

        const nextRemaining = remaining - 1;

        const nextSubEvent = {
          id: nextSubEventId,
          startAt: firestore.Timestamp.fromDate(nextSubEventDate),
          endAt: firestore.Timestamp.fromDate(nextSubEventDeadlineDate),
        };

        const batch = db.batch();

        batch.update(docRef, {
          remaining: nextRemaining,
          activeSessionId: nextSubEventId,
          subEventDeadline: firestore.Timestamp.fromDate(
            nextSubEventDeadlineDate
          ),
        });
        batch.set(
          docRef.collection("sessions").doc(nextSubEventId),
          nextSubEvent
        );
        return batch.commit();
      } else {
        //chiudo l evento
        return docRef.update({
          subEventDeadline: null,
          status: "closed",
        });
      }
    }
  );
}

// only internals
/*
export const cronForTest = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      await updateSubEvent();
    }
  );
*/

// only internals
/*export const changeClaim = functions
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
*/

// Only for testing
/*
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
*/

/*
//Only for testing
export const processEvents = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        const now = new Date();
        console.log("This will be run every 30 minutes" + now.toISOString());

        const nowUTC = dateToUTC(new Date());
        console.log(nowUTC);
        //prendo tutti gli eventi attivi ricorrenti che sono da aggiornare (query su subEventDeadline)
        const querySnapshot = await db
          .collectionGroup("events")
          .where("status", "==", "live")
          //.where("recurring", "==", true)
          .where("type", "==", "periodic")
          .where("subEventDeadline", "<=", nowUTC)
          .get();

        console.log("trovati " + querySnapshot.size + " docs");

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
              } else if (recurrence === "weekly") {
                multiplier = 7;
              }

              // Data di fine sessione
              const subEventDeadlineTimestamp: FirebaseFirestore.Timestamp =
                data.subEventDeadline;
              const subEventDeadlineDate = subEventDeadlineTimestamp.toDate();

              // Prossima data di fine sessione
              let nextSubEventDeadlineDate: Date = addDays(
                multiplier,
                subEventDeadlineDate
              );

              console.log(subEventDeadlineDate);
              console.log(nextSubEventDeadlineDate);

              const nextSubEventId =
                subEventDeadlineDate.getFullYear() +
                "-" +
                ("0" + (subEventDeadlineDate.getMonth() + 1)).slice(-2) +
                "-" +
                ("0" + subEventDeadlineDate.getDate()).slice(-2);

              console.log("nextSubEventId " + nextSubEventId);

              const nextRemaining = remaining - 1;

              const nextSubEventDeadlineTimestamp: firestore.Timestamp =
                firestore.Timestamp.fromDate(nextSubEventDeadlineDate);

              const nextSubEvent = {
                id: nextSubEventId,
                startAt: subEventDeadlineTimestamp,
                endAt: nextSubEventDeadlineTimestamp,
              };

              await docRef.update({
                remaining: nextRemaining,
                activeSessionId: nextSubEventId,
                subEventDeadline: nextSubEventDeadlineTimestamp,
              });

              await docRef
                .collection("sessions")
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
        response
          .status(200)
          .send("There are " + querySnapshot.size + " events");
      });
    }
  );

/*
export const exportDbToJson = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        const credentials = await credentialsCollectionRef().limit(1).get();
        const providers = await providersCollectionRef().limit(1).get();
        const providerId = providers.docs[0].data().id;
        const event = await eventCollectionRef(providerId).limit(1).get();
        const user = await usersCollectionRef(providerId).limit(1).get();
        const userPrivate = await privateUsersCollectionRef().limit(1).get();

        const data = {
          credentials: credentials.docs[0].data(),
          providers: providers.docs[0].data(),
          event: event.docs[0].data(),
          user: user.docs[0].data(),
          userPrivate: userPrivate.docs[0].data(),
        };
        response.status(200).send(data);
      });
    }
  );
*/

//Only for testing
/*
export const copyFirebaseDoc = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        const data = request.body;
        const fromRef = data.fromRef;
        const toRef = data.toRef;

        const dbFromRef = db.doc(fromRef);
        const fromDoc = await dbFromRef.get();
        await db.doc(toRef).set(fromDoc.data());
        response.send("Ok");
      });
    }
  );
  */

//Only for testing
/*
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
*/

//Only for testing
/*export const verifyEmail = functions
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
  );*/
