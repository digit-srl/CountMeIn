import * as functions from "firebase-functions";
const admin = require("firebase-admin");
import Email = require("./email");
const draw = require("./draw");
const db = admin.firestore();
const cors = require("cors")({ origin: true });
import * as firestore from "@google-cloud/firestore";
import * as utils from "./firestore_utils";
import {
  privateUsersCollectionRef,
  providerDocRef,
  userDocRef,
  usersCollectionRef,
  userGroupCollectionRef,
  managerDocRef,
} from "./firestore_references";
import {
  generateAndSendResetPasswordEmail,
  getProviderData,
  twoDecimalPlaces,
} from "./utils";
import { DecodedIdToken } from "firebase-admin/auth";
const randomstring = require("randomstring");
const CodiceFiscale = require("codice-fiscale-js");

/// OUTPUT STATUS
/// user_already_exist:
/// invalid_fiscal_code:
export const createUser = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }
        //const now = new Date();
        const data = request.body;
        const email = data.email;
        const cf = data.cf;
        const providerId = data.providerId;

        if (providerId == null || cf == null) {
          const message = "CF or providerId are missing";
          console.error(message);
          response.status(400).send("invalid-argument");
          return;
        }

        if (email == null) {
          const message = "email is missing";
          console.error(message);
          response.status(400).send("invalid-argument");
          return;
        }

        if (!CodiceFiscale.check(cf)) {
          response
            .send({
              status: "invalid_fiscal_code",
              cf: cf,
            })
            .end();
          return;
        }

        console.log("user " + email + " cf: " + cf + " request creation");
        const d = await usersCollectionRef(providerId)
          .where("cf", "==", cf)
          .where("emailVerified", "==", true)
          .limit(1)
          .get();

        // se c'è almeno 1 doc l utente è già registrato e verificato nella piattaforma
        if (d.docs.length > 0) {
          console.log(d.docs[0].data());
          const userData = d.docs[0].data();

          /*
        if (userData.emailVerified) {
          if (data.providerId !== null && data.providerName !== null) {
            sendUserCard(userData, data.providerId, data.providerName);
             }
        }*/

          response
            .send({
              status: "user_already_exist",
              emailVerified: userData.emailVerified,
              userId: userData.id,
              cf: cf,
            })
            .end();
          return;
        }

        // Utente non esiste

        if (
          email == null ||
          data.name == null ||
          data.surname == null ||
          data.providerName == null
        ) {
          console.log("Some field is null");
          response.status(400).send("invalid-argument");
          return;
        }

        try {
          const timestampNow = firestore.Timestamp.fromDate(new Date());

          const batch = db.batch();
          const userRef = usersCollectionRef(providerId).doc();
          const secret = randomstring.generate(8);

          batch.set(userRef, {
            emailVerified: false,
            name: data.name,
            id: userRef.id,
            cf: data.cf,
            addedOn: timestampNow,
            surname: data.surname,
            email: data.email,
            secret: secret,
            //providerId: data.providerId,
            //providerName: data.providerName,
          });

          /*
          const fiscalCode = new CodiceFiscale(cf);
            const bornIn = fiscalCode.birthday;
          const bornInTimestamp = firestore.Timestamp.fromDate(bornIn);
          const userPrivateRef = privateUsersCollectionRef(providerId).doc();
          batch.set(userPrivateRef, {
            id: userPrivateRef.id,
            bornIn: bornInTimestamp,
            gender: data.gender,
          });
          */

          await batch.commit();
          console.log("new user crated " + data.email);

          const fullName = data.name + " " + data.surname;
          Email.sendVerificationEmail(
            fullName,
            data.email,
            userRef.id,
            secret,
            data.providerId
            //userPrivateRef.id
          );
          response
            .send({
              status: "success",
              cf: cf,
            })
            .end();
        } catch (err: any) {
          console.error(err);
          response.status(500).send(err);
        }
      });
    }
  );

export const verifyEmail = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }

        const data = request.body;
        const userId = data.userId;
        const providerId = data.providerId;
        const secret = data.secret;

        if (providerId == null || secret == null || userId == null) {
          const message =
            "Missing data: providerId: " +
            providerId +
            ", secret: " +
            secret +
            ", userId: " +
            userId;
          console.log(message);
          response.status(400).send("invalid-argument");
          return;
        }

        const userDoc = await usersCollectionRef(providerId).doc(userId).get();
        const userData = userDoc.data();
        if (!userDoc.exists || userData == null) {
          console.log("User not found");
          response.status(404).send("user-not-found");
          return;
        }

        // Questo utente ha già verificato la sua email
        if (userData.emailVerified) {
          response.send({
            status: "user_already_verified",
          });
          return;
        }

        // Controllo se esiste un utente con cf uguale e verificato
        const cf = userData.cf;
        const d = await usersCollectionRef(providerId)
          .where("cf", "==", cf)
          .where("emailVerified", "==", true)
          .limit(1)
          .get();

        // Esiste già un utente con questo cf con email verificata
        // quindi non possiamo verificarne un'altra
        if (d.docs.length > 0) {
          response.send({
            status: "user_already_verified_with_another_email",
          });
          return;
        }

        if (userData.secret !== null && userData.secret == secret) {
          await userDocRef(providerId, userId).update({
            secret: null,
            emailVerified: true,
          });

          const providerDoc = await providerDocRef(providerId).get();
          if (providerDoc == null || !providerDoc.exists) {
            console.log("provider is null");
            response.status(404).send("provider-not-found");
            return;
          }
          //const providerName = providerDoc.data()?.name;
          //await sendUserCard(userData, providerId, providerName, privateId);
          response.send({
            status: "verified",
          });
        } else {
          console.log("secret is not correct");
          response.status(400).send("invalid-argument");
          return;
        }
      });
    }
  );

// Richiede la generazione del tesserino e lo invia all utente
// che ha già verificato la sua email
export const recoverUserCard = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }

        const data = request.body;
        const userId = data.userId;
        const cf = data.cf;
        const providerId = data.providerId;
        const gender = data.gender;

        if (
          providerId == null ||
          userId == null ||
          cf == null ||
          gender == null
        ) {
          const message =
            "Missing data: providerId: " +
            providerId +
            ", userId: " +
            userId +
            ", cf: " +
            cf +
            ", gender: " +
            gender;
          console.error(message);
          response.status(400).send("invalid-argument");
          return;
        }

        const userDoc = await usersCollectionRef(providerId).doc(userId).get();

        if (!userDoc.exists) {
          console.log("User not found");
          throw new functions.https.HttpsError("not-found", "User not found");
        }
        const userData = userDoc.data();

        if (userData == null) {
          console.log("User data null");
          throw new functions.https.HttpsError("not-found", "User data null");
        }

        //TODO inserire controllo ultimo accesso, se piu tardi i 2 ore richiedere otp code
        const providerDoc = await providerDocRef(providerId).get();
        if (!providerDoc.exists) {
          console.log("Provider not found");
          throw new functions.https.HttpsError(
            "not-found",
            "Provider not found"
          );
        }
        const providerData = providerDoc.data();

        if (providerData == null) {
          console.log("Provider data null");
          throw new functions.https.HttpsError(
            "not-found",
            "Provider data null"
          );
        }

        const providerName = providerData.name;
        const fiscalCode = new CodiceFiscale(cf);
        const bornIn = fiscalCode.birthday;
        try {
          const bornInTimestamp = firestore.Timestamp.fromDate(bornIn);
          const batch = db.batch();
          const userPrivateRef = privateUsersCollectionRef().doc();
          const privateId = userPrivateRef.id;
          batch.set(userPrivateRef, {
            id: privateId,
            bornIn: bornInTimestamp,
            gender: gender,
          });
          await batch.commit();
          console.log("private date set on" + userPrivateRef.path);
          await sendUserCard(userData, providerId, providerName, privateId);
          response.sendStatus(200);
        } catch (err: any) {
          console.error(err);
          response.status(500).send(err);
        }
      });
    }
  );

export const requestGroupCard = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }

        const data = request.body;
        const providerId = data.providerId;
        const userId = data.userId;
        const groupCount = data.groupCount;
        const averageAge = data.averageAge;
        const groupName = data.groupName;

        if (
          providerId == null ||
          userId == null ||
          groupCount == null ||
          groupName == null
        ) {
          const message = "Some fields are null";
          console.error(message);
          response.status(400).send("invalid-argument");
          return;
        }

        const maleCount = data.maleCount;
        const femaleCount = data.femaleCount;

        if (
          maleCount != null &&
          femaleCount != null &&
          maleCount + femaleCount != groupCount
        ) {
          const message = "There is a error about gender count";
          console.error(message);
          response.status(400).send({
            error: "invalid-argument",
            message: message,
          });
          return;
        }

        const manPercentage =
          maleCount != null ? maleCount / groupCount : undefined;
        const womanPercentage =
          femaleCount != null ? femaleCount / groupCount : undefined;

        console.log(
          "maleCount: " +
            maleCount +
            ", femaleCount:" +
            femaleCount +
            ", manPercentage:" +
            manPercentage +
            ", womanPercentage:" +
            womanPercentage
        );
        try {
          const userData = await utils.getUserData(providerId, userId);
          const providerData = await getProviderData(providerId);
          const groupDocRef = userGroupCollectionRef(providerId, userId).doc();
          const groupId = groupDocRef.id;
          await groupDocRef.set({
            id: groupId,
            groupName: groupName,
            groupCount: groupCount,
            averageAge: averageAge,
            maleCount: maleCount,
            femaleCount: femaleCount,
          });
          await sendGroupCard(
            userData,
            groupId,
            providerId,
            providerData.name,
            groupName,
            groupCount,
            averageAge,
            manPercentage,
            womanPercentage
          );

          response.sendStatus(200);
        } catch (ex) {
          console.log(ex);
          response.status(404).send("error");
        }
      });
    }
  );

export const sendResetPasswordEmail = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }

        const data = request.body;
        const userEmail = data.email;

        if (userEmail === undefined || userEmail === null || userEmail === "") {
          response.status(400).send("userEmail userId");
          return;
        }

        //TODO controlla che lo userId appartiene a quella email
        const user = await admin.auth().getUserByEmail(userEmail);

        if (user == null) {
          response.status(400).send("user doesn't exists");
          return;
        }
        const fullName = user.displayName;

        return generateAndSendResetPasswordEmail(fullName, userEmail, user.uid)
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
      });
    }
  );

export const changePassword = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }

        const data = request.body;
        const newPassword = data.newPassword;
        const token = data.token;

        if (newPassword == null) {
          response.status(400).send("passowrd is not valid");
          return;
        }

        return admin
          .auth()
          .verifyIdToken(token)
          .then((decodedToken: DecodedIdToken) => {
            const uid = decodedToken.uid;
            return admin
              .auth()
              .updateUser(uid, {
                password: newPassword,
              })
              .then(async () => {
                await managerDocRef(uid).update({
                  temporaryPassword: false,
                });
                return response.status(200).send("Ok");
              })
              .catch((error: unknown) => {
                console.log(error);
                return response
                  .status(500)
                  .send("Errore durante aggiornamento password");
              });
          })
          .catch((error: unknown) => {
            console.log(error);
            return response.status(500).send("Token non valido");
          });
      });
    }
  );

/*
export const sendCardTest = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        const buffer1 = await draw.drawUserCard(
          "TEST",
          "Gian Marco",
          "Di Francesco",
          "DFRGMR89M02I348U",
          "difrancescogianmarco@gmail.com",
          encodeURI("https://cmi.digit.srl/profile/"),
          "userId",
          "privateId",
          "providerId"
        );

        const buffer2 = await draw.drawGroupCard(
          "TEST",
          "Gian Marco",
          "Di Francesco",
          "DFRGMR89M02I348U",
          "difrancescogianmarco@gmail.com",
          encodeURI("https://cmi.digit.srl/profile/"),
          "GROUP NAME",
          "12",
          "5",
          90,
          10
        );

        await Email.sendGroupCardEmail(
          "Gain Marco Di Francesco",
          "difrancescogianmarco@gmail.com",
          "DFRGMR89M02I348U",

          buffer2,
          "TEST PROVIDER",
          "GROUP NAME"
        ).catch((err: any) => {
          console.error(err);
          throw err;
        });

        return Email.sendUserCardEmail(
          "Gain Marco Di Francesco",
          "difrancescogianmarco@gmail.com",
          "DFRGMR89M02I348U",
          buffer1,
          "TEST PROVIDER"
        )
          .then(() => {
            return true;
          })
          .catch((err: any) => {
            console.error(err);
            throw err;
          });
      });
    }
  );*/

async function sendUserCard(
  data: FirebaseFirestore.DocumentData,
  providerId: string,
  providerName: string,
  privateId: string
) {
  const userId = data.id;
  const name = data.name;
  const surname = data.surname;
  const fullName = name + " " + surname;
  const cf = data.cf;
  const email = data.email;
  const url =
    "https://cmi.digit.srl/profile/" +
    userId +
    "?" +
    "upid=" +
    privateId +
    "&name=" +
    name +
    "&surname=" +
    surname +
    "&cf=" +
    cf +
    "&pId=" +
    providerId;

  const buffer = await draw.drawUserCard(
    providerName,
    name,
    surname,
    cf,
    email,
    encodeURI(url),
    userId,
    privateId,
    providerId
  );
  return Email.sendUserCardEmail(fullName, email, cf, buffer, providerName)
    .then(() => {
      return true;
    })
    .catch((err: any) => {
      console.error(err);
      throw err;
    });
}

async function sendGroupCard(
  data: FirebaseFirestore.DocumentData,
  groupId: string,
  providerId: string,
  providerName: string,
  groupName: string,
  groupCount: number,
  averageAge: number | undefined,
  manPercentage: number | undefined,
  womanPercentage: number | undefined
) {
  const userId = data.id;
  const name = data.name;
  const surname = data.surname;
  const fullName = name + " " + surname;
  const cf = data.cf;
  const email = data.email;
  var url =
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
    providerId +
    "&gId=" +
    groupId +
    "&gN=" +
    groupName +
    "&gC=" +
    groupCount;

  if (manPercentage != null) {
    url = url + "&mP=" + twoDecimalPlaces(manPercentage);
  }

  if (womanPercentage != null) {
    url = url + "&wP=" + twoDecimalPlaces(womanPercentage);
  }

  if (averageAge != null) {
    url = url + "&aA=" + averageAge;
  }
  const buffer = await draw.drawGroupCard(
    providerName,
    name,
    surname,
    cf,
    email,
    encodeURI(url),
    groupName,
    groupCount.toString(),
    averageAge?.toString(),
    manPercentage,
    womanPercentage
  );
  return Email.sendGroupCardEmail(
    fullName,
    email,
    cf,
    buffer,
    providerName,
    groupName
  )
    .then(() => {
      return true;
    })
    .catch((err: any) => {
      console.error(err);
      throw err;
    });
}
