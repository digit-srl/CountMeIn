import * as functions from "firebase-functions";
const admin = require("firebase-admin");
const db = admin.firestore();
import * as firestore from "@google-cloud/firestore";
import Email = require("./email");
const cors = require("cors")({ origin: true });

function usersCollectionRef() {
  return db.collection("users");
}

function userAccessCollectionRef(userId: String) {
  return userDocRef(userId).collection("accesses");
}

function userDocRef(userId: String) {
  return usersCollectionRef().doc(userId);
}

async function getLastAccessRequest(
  userId: string
): Promise<FirebaseFirestore.DocumentSnapshot[]> {
  const accesses = await userAccessCollectionRef(userId)
    .where("status", "==", "waiting")
    .orderBy("requestedOn")
    .limit(1)
    .get();

  return accesses.docs;
}

exports.requestOtpCode = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }
        const now = new Date();
        const data = request.body;
        const userId = data.userId;

        if (userId === undefined || userId === null) {
          const message = "Missing data on request: userId= " + userId;
          console.log(message);
          throw new functions.https.HttpsError("invalid-argument", message);
        }
        console.log("userId: " + userId);

        const userDoc = await userDocRef(userId).get();
        if (!userDoc.exists) {
          console.log("User not found");
          throw new functions.https.HttpsError("not-found", "User not found");
        }
        const userData = userDoc.data();
        const fullName = userData.name + " " + userData.surname;
        const email = userData.email;
        const requests = await getLastAccessRequest(userId);

        if (requests.length == 0) {
          const otpCode = makeOTP();
          const accessRef = userAccessCollectionRef(userId).doc();
          await accessRef.set({
            id: accessRef.id,
            otpCode: otpCode,
            requestedOn: firestore.Timestamp.fromDate(now),
            status: "waiting",
          });

          await Email.sentUserProfileOtpCode(fullName, otpCode, email);

          console.log("first request, email sent, otpCode: " + otpCode);
          response
            .send({
              status: "email_sent",
            })
            .end();
        } else {
          ///TODO controllare validità in base alla differenza now accessOn
          // se vecchio iniviare nuovo otp code

          if (requests[0].exists) {
            const lastAccessRequest = requests[0].data();
            if (lastAccessRequest !== undefined && lastAccessRequest !== null) {
              console.log(
                "Using old request, email sent, otpCode: " +
                  lastAccessRequest.otpCode
              );
              await Email.sentUserProfileOtpCode(
                fullName,
                lastAccessRequest.otpCode,
                email
              );
              response
                .send({
                  status: "email_sent",
                })
                .end();
              return;
            }
          }
        }
      });
    }
  );

exports.verifyOtpCode = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }
        const now = new Date();
        const data = request.body;
        const userId = data.userId;
        const otpCode = data.otpCode;

        if (
          userId === undefined ||
          userId === null ||
          otpCode === undefined ||
          otpCode === null
        ) {
          const message =
            "Missing data on request: userId= " +
            userId +
            ", otpCode= " +
            otpCode;
          console.log(message);
          throw new functions.https.HttpsError("invalid-argument", message);
        }
        console.log("userId: " + userId + ", otp: " + otpCode);

        const userDoc = await userDocRef(userId).get();
        if (!userDoc.exists) {
          console.log("User not found");
          throw new functions.https.HttpsError("not-found", "User not found");
        }
        const userData = userDoc.data();
        const requests = await getLastAccessRequest(userId);

        if (requests.length == 0) {
          response.status(404).send({
            error:
              "there aren't active requests, you must request new otp code",
          });
        } else {
          const lastAccessRequest = requests[0].data();
          if (lastAccessRequest !== undefined && lastAccessRequest !== null) {
            if (otpCode == lastAccessRequest.otpCode) {
              userAccessCollectionRef(userId)
                .doc(lastAccessRequest.id)
                .update({
                  accessOn: firestore.Timestamp.fromDate(now),
                  status: "used",
                });
              response.send(userData).end();
            } else {
              console.log("invalid otp code");
              throw new functions.https.HttpsError(
                "not-found",
                "invalid otp code"
              );
            }
          }
        }
      });
    }
  );

function makeOTP() {
  var result = "";
  var characters = "0123456789";
  var charactersLength = characters.length;
  for (var i = 0; i < 5; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}
