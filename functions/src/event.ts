import * as functions from "firebase-functions";
const admin = require("firebase-admin");
const db = admin.firestore();
import * as firestore from "@google-cloud/firestore";
import Email = require("./email");
const axios = require("axios").default;
import {
  eventDocRef,
  userDocRef,
  providerDocRef,
  privateUserDocRef,
} from "./firestore_references";

exports.onPrivateUserCheckIn = functions
  .region("europe-west3")
  .firestore.document(
    "providers/{providerId}/events/{eventId}/subEvents/{subEventId}/privateUsers/{userId}"
  )
  .onWrite(async (snap, context) => {
    try {
      const providerId = context.params.providerId;
      const userId = context.params.userId;

      //utente cancellato
      if (!snap.after.exists) {
        console.log("utente rimosso da " + "eventId: " + userId);
        return;
      }

      const privateEventUserData: FirebaseFirestore.DocumentData | undefined =
        snap.after.data();
      console.log("user check in private id: " + privateEventUserData?.id);

      if (privateEventUserData === undefined || privateEventUserData === null) {
        console.log("privateEventUserDoc undefined ");
        return null;
      }

      const privateId = privateEventUserData.id;

      const privateUserDoc: FirebaseFirestore.DocumentData =
        await privateUserDocRef(providerId, privateId).get();

      if (privateUserDoc.exists) {
        const userData = privateUserDoc.data();

        const gender = userData.gender;
        if (gender != null) {
          let increment = 1;
          let m = 0;
          let f = 0;
          let na = 0;
          if (snap.after.exists && !snap.before.exists) {
            increment = 1;
          } else if (!snap.after.exists && snap.before.exists) {
            increment = -1;
          }

          if (gender == "male") {
            m = increment;
          } else if (gender == "female") {
            f = increment;
          } else if (gender == "notBinary") {
            na = increment;
          }

          if (m != 0 || f != 0 || na != 0) {
            console.log("m: " + m + ",f: " + f + ",na: " + na);
            const countRef = snap.after.ref.parent.parent;
            if (countRef != null) {
              await db.runTransaction(
                async (transaction: FirebaseFirestore.Transaction) => {
                  await transaction.update(countRef, {
                    "genderCount.male": firestore.FieldValue.increment(m),
                    "genderCount.female": firestore.FieldValue.increment(f),
                    "genderCount.notBinary": firestore.FieldValue.increment(na),
                  });
                }
              );
              //await countRef.update((current) => {
              //  return (current || 0) + increment;
              //});
              functions.logger.log("Gender counter updated.");
            }
          }
        } else {
          console.log("gender infot doesnt exists");
        }
      } else {
        console.log("private user doc doesnt exists");
      }
      return null;
    } catch (ex) {
      console.log("onUpdateCheckIn failed");
      console.log(ex);
      return null;
    }
  });

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

      console.log(
        "providerId" +
          providerId +
          " eventId: " +
          eventId +
          " userId: " +
          userId
      );

      //utente cancellato
      if (!snap.after.exists) {
        console.log("utente rimosso da " + "eventId: " + userId);
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
      const fromExternalOrganization = user.fromExternalOrganization;

      if (checkOutAt === undefined || checkOutAt === null) {
        console.log(
          "Missing checkOut: this trigger need of checkOut date to release wom"
        );
        return;
      }

      const isGroup = user.isGroup;

      //Incrementiamo il numero degli utenti totali
      const groupCount = isGroup ? user.groupCount ?? 0 : 1;
      const eventRef = snap.after.ref.parent.parent;
      if (eventRef != null) {
        await db.runTransaction(
          async (transaction: FirebaseFirestore.Transaction) => {
            await transaction.update(eventRef, {
              totalUsers: firestore.FieldValue.increment(groupCount),
            });
          }
        );
      }

      //Se è un gruppo terminiamo la funzione in quanto i passaggi successivi sono relativi al rilascio dei wom
      if (isGroup) {
        console.log("The user is a group, a group will not receive woms");
        return;
      }

      const eventDoc: FirebaseFirestore.DocumentData = await eventDocRef(
        providerId,
        eventId
      ).get();

      const event = eventDoc.data();
      const womCount = event.maxWomCount;
      const eventName = event.name;
      const eventAccessType = event.accessType;
      console.log(eventName);

      if (womCount === undefined || womCount === null || womCount === 0) {
        console.log("this event not release wom to user : " + userId);
        return;
      }

      if (
        eventAccessType === "inOut" &&
        (checkInAt === undefined || checkInAt === null)
      ) {
        console.log("Event with in/out access must to have checkInAt defined");
        return null;
      }

      let userData: any | undefined;

      // se il tesserino è di una organizzazione esterna (es: università)
      // prendo i dati direttamente dal doc del checkin/out
      if (fromExternalOrganization) {
        if (
          !(
            user.email == null ||
            user.name == null ||
            user.surname == null ||
            user.cf == null ||
            user.id == null
          )
        ) {
          userData = {
            email: user.email,
            id: user.id,
            name: user.name,
            surname: user.surname,
            cf: user.cf,
          };
        }
      }

      if (!fromExternalOrganization && userData == null) {
        const userDoc: FirebaseFirestore.DocumentData = await userDocRef(
          providerId,
          userId
        ).get();

        userData = userDoc.data();
      }

      const email = userData.email;
      if (email === undefined || email === null) {
        console.log("STOP user not exist email undefined ");
        return null;
      }
      console.log("user exist email " + userData.email);

      const providerDoc: FirebaseFirestore.DocumentData = await providerDocRef(
        providerId
      ).get();

      let wom = womCount;

      if (eventAccessType === "inOut") {
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
