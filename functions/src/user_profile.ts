import * as functions from "firebase-functions";
import * as firestore from "@google-cloud/firestore";
const admin = require("firebase-admin");
const db = admin.firestore();
import Email = require("./email");
const cors = require("cors")({ origin: true });
const CodiceFiscale = require("codice-fiscale-js");
import {
  userDocRef,
  userAccessCollectionRef,
  usersCollectionRef,
} from "./firestore_references";

async function getLastAccessRequest(
  providerId: string,
  userId: string
): Promise<FirebaseFirestore.DocumentSnapshot[]> {
  const accesses = await userAccessCollectionRef(providerId, userId)
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
        const providerId = data.providerId;
        const userId = data.userId;

        if (
          userId === undefined ||
          userId === null ||
          providerId === undefined ||
          providerId === null
        ) {
          const message =
            "Missing data on request: userId= " +
            userId +
            ", providerId= " +
            providerId;
          console.log(message);

          response.status(400).send("invalid-argument");
          return;
          //throw new functions.https.HttpsError("invalid-argument", message);
        }
        console.log("userId: " + userId);

        const userDoc = await userDocRef(providerId, userId).get();
        const userData = userDoc.data();
        if (!userDoc.exists || userData == null) {
          console.log("User not found");
          response.status(404).send("user-not-found");
          return;
          //throw new functions.https.HttpsError("not-found", "User not found");
        }

        const fullName = userData.name + " " + userData.surname;
        const email = userData.email;
        const requests = await getLastAccessRequest(providerId, userId);

        if (requests.length == 0) {
          const otpCode = makeOTP();
          const accessRef = userAccessCollectionRef(providerId, userId).doc();
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
        const providerId = data.providerId;
        const otpCode = data.otpCode;

        if (
          providerId === undefined ||
          providerId === null ||
          userId === undefined ||
          userId === null ||
          otpCode === undefined ||
          otpCode === null
        ) {
          const message =
            "Missing data on request: providerId= " +
            providerId +
            ", userId= " +
            userId +
            ", otpCode= " +
            otpCode;
          console.log(message);
          response.status(400).send("invalid-argument");
          return;
          //throw new functions.https.HttpsError("invalid-argument", message);
        }
        console.log("userId: " + userId + ", otp: " + otpCode);

        const userDoc = await userDocRef(providerId, userId).get();
        const userData = userDoc.data();
        if (!userDoc.exists || userData == null) {
          console.log("User not found");
          response.status(404).send("user-not-found");
          return;
          //throw new functions.https.HttpsError("not-found", "User not found");
        }

        const requests = await getLastAccessRequest(providerId, userId);

        if (requests.length == 0) {
          response.status(404).send({
            error:
              "there aren't active requests, you must request new otp code",
          });
        } else {
          const lastAccessRequest = requests[0].data();
          if (lastAccessRequest !== undefined && lastAccessRequest !== null) {
            if (otpCode == lastAccessRequest.otpCode) {
              const batch = db.batch();
              batch.update(
                userAccessCollectionRef(providerId, userId).doc(
                  lastAccessRequest.id
                ),
                {
                  accessOn: firestore.Timestamp.fromDate(now),
                  status: "used",
                }
              );
              if (!userData.emailVerified) {
                batch.update(userDocRef(providerId, userId), {
                  emailVerified: true,
                  secret: null,
                });
              }
              await batch.commit();
              /* userAccessCollectionRef(providerId, userId)
                .doc(lastAccessRequest.id)
                .update({
                  accessOn: firestore.Timestamp.fromDate(now),
                  status: "used",
                });*/
              response.send(userData).end();
            } else {
              console.log("invalid otp code");
              response.status(400).send("invalid-argument");
              return;
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

/// OUTPUT STATUS
/// user_already_exist:
/// invalid_fiscal_code:
exports.recoverUser = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      console.log(request.body);
      cors(request, response, async () => {
        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }
        const now = new Date();
        const data = request.body;

        if (data.providerId == null || data.cf == null) {
          const message = "CF or providerId are missing";
          console.log(message);
          throw new functions.https.HttpsError("invalid-argument", message);
        }
        const cf = data.cf.toUpperCase();
        const providerId = data.providerId;

        if (!CodiceFiscale.check(cf)) {
          response
            .send({
              status: "invalid_fiscal_code",
            })
            .end();
          return;
        }

        const d = await usersCollectionRef(providerId)
          .where("cf", "==", cf)
          .limit(1)
          .get();

        if (d.docs.length > 0) {
          console.log(d.docs[0].data());
          const userData = d.docs[0].data();
          const userId = userData.id;
          const fullName = userData.name + " " + userData.surname;
          const email = userData.email;
          const requests = await getLastAccessRequest(providerId, userId);
          if (requests.length == 0) {
            const otpCode = makeOTP();
            const accessRef = userAccessCollectionRef(providerId, userId).doc();
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
                userId: userId,
              })
              .end();
          } else {
            ///TODO controllare validità in base alla differenza now accessOn
            // se vecchio iniviare nuovo otp code

            if (requests[0].exists) {
              const lastAccessRequest = requests[0].data();
              if (
                lastAccessRequest !== undefined &&
                lastAccessRequest !== null
              ) {
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
                    userId: userId,
                  })
                  .end();
                return;
              }
            }
          }
        } else {
          // USER not exists
          response
            .send({
              status: "user_not_exists",
            })
            .end();
          return;
        }
      });
    }
  );
