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
} from "./firestore_references";
const randomstring = require("randomstring");
const CodiceFiscale = require("codice-fiscale-js");

/// OUTPUT STATUS
/// user_already_exist:
/// invalid_fiscal_code:
exports.createUser = functions
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

        if (!CodiceFiscale.check(cf)) {
          response
            .send({
              status: "invalid_fiscal_code",
            })
            .end();
          return;
        }

        console.log("user " + email + " request creation");
        const d = await usersCollectionRef(providerId)
          .where("cf", "==", cf)
          .limit(1)
          .get();

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
            })
            .end();
          return;
        }

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
            })
            .end();
        } catch (err: any) {
          console.error(err);
          response.status(500).send(err);
        }
      });
    }
  );

exports.verifyEmail = functions
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

        if (
          userData != null &&
          userData.secret !== null &&
          userData.secret == secret
        ) {
          if (userData.emailVerified) {
            response.send({
              status: "user_already_verified",
            });
            return;
          }

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
          response.sendStatus(200);
        } else {
          console.log("secret is not correct");
          response.status(400).send("invalid-argument");
          return;
        }
      });
    }
  );

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
    url,
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
    url = url + "&mP=" + manPercentage;
  }

  if (womanPercentage != null) {
    url = url + "&wP=" + womanPercentage;
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

exports.recoverUserCard = functions
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

exports.requestGroupCard = functions
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
        const womanPercentage = data.womanPercentage;
        const manPercentage = data.manPercentage;
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
            manPercentage: manPercentage,
            womanPercentage: womanPercentage,
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

async function getProviderData(
  providerId: string
): Promise<firestore.DocumentData> {
  const providerDoc = await providerDocRef(providerId).get();
  const providerData = providerDoc.data();
  if (!providerDoc.exists || providerData == null) {
    console.log("User not found");
    throw Error();
  }
  return providerData;
}
