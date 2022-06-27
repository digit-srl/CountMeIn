import { AuthUser } from "./AuthUser";
import * as functions from "firebase-functions";
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase!");
});

export const onAuthCreate = functions.auth.user().onCreate((user) => {
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

export const onActivityRequested = functions.firestore
  .document("activityRequests/{docId}")
  .onCreate((snap, context) => {
    // Get an object representing the document
    // e.g. {'name': 'Marie', 'age': 66}
    const activity = snap.data();

    console.log("new activity requested" + activity.name);
    console.log("new activity requested");
  });
