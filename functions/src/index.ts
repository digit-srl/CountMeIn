import { AuthUser } from "./AuthUser";
import * as functions from "firebase-functions";
const admin = require("firebase-admin");
admin.initializeApp();
import Email = require("./email");
const draw = require("./draw");
import * as dotenv from "dotenv";
dotenv.config();
const db = admin.firestore();

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

export const onActivityRequested = functions
  .region("europe-west3")
  .firestore.document("activityRequests/{docId}")
  .onCreate((snap, context) => {
    const activity = snap.data();

    console.log("new activity requested" + activity.name);
    console.log("new activity requested");
  });

export const onUserCreated = functions
  .region("europe-west3")
  .firestore.document("users/{docId}")
  .onCreate((snap, context) => {
    const user = snap.data();

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
    const emailVerified = user.emailVerified;

    // ...or the previous value before this update
    const previousValue = change.before.data();
    const previousEmailVerified = previousValue.emailVerified;

    if (secret === undefined || secret === null) {
      if (emailVerified === true && previousEmailVerified == false) {
        // const fullName = user.name + " " + user.surname;
        return sendUserCard(user)
          .then(() => {
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

function sendUserCard(data: FirebaseFirestore.DocumentData) {
  const userId = data.id;
  const name = data.name;
  const surname = data.surname;
  const fullName = name + " " + surname;
  const cf = data.cf;
  const email = data.email;
  const activityName = data.activityName;
  const activityId = data.activityId;
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
    "&aId=" +
    activityId +
    "&email=" +
    email;

  return draw
    .drawUserCard(activityName, name, surname, cf, email, url)
    .then((buffer: Buffer) => {
      return Email.sendUserCardEmail(fullName, email, cf, buffer)
        .then(() => {
          return null;
        })
        .catch((err: any) => {
          console.log(err);
          throw new functions.https.HttpsError("aborted", err);
        });
    })
    .catch((err: any) => {
      throw new functions.https.HttpsError("unknown", err);
    });
}
