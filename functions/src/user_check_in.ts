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

exports.onPrivateSessionUserCheckIn = functions
  .region("europe-west3")
  .firestore.document(
    "providers/{providerId}/events/{eventId}/sessions/{sessionId}/privateUsers/{userId}"
  )
  .onWrite(async (snap, context) => {
    try {
      //const providerId = context.params.providerId;
      const userId = context.params.userId;

      //utente cancellato
      if (!snap.after.exists) {
        console.log(
          "onPrivateUserCheckIn: utente rimosso da " + "eventId: " + userId
        );
        return;
      }

      const privateEventUserData: FirebaseFirestore.DocumentData | undefined =
        snap.after.data();
      console.log(
        "onPrivateUserCheckIn: user check in private id: " +
          privateEventUserData?.id
      );

      if (privateEventUserData === undefined || privateEventUserData === null) {
        console.log("onPrivateUserCheckIn: privateEventUserDoc undefined ");
        return null;
      }

      const privateId = privateEventUserData.id;

      const privateUserDoc: FirebaseFirestore.DocumentData =
        await privateUserDocRef(privateId).get();

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
            console.log(
              "onPrivateUserCheckIn: m: " + m + ",f: " + f + ",na: " + na
            );
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
          console.log("onPrivateUserCheckIn: gender infot doesnt exists");
        }
      } else {
        console.log("onPrivateUserCheckIn: private user doc doesnt exists");
      }
      return null;
    } catch (ex) {
      console.log("onPrivateUserCheckIn failed");
      console.log(ex);
      return null;
    }
  });

export const onSessionUserCheckIn = functions
  .region("europe-west3")
  .firestore.document(
    "providers/{providerId}/events/{eventId}/sessions/{sessionId}/users/{userId}"
  )
  .onWrite(async (snap, context) => {
    try {
      const eventId = context.params.eventId;
      const sessionId = context.params.sessionId;
      const providerId = context.params.providerId;
      const userId = context.params.userId;
      const eventRef = snap.after.ref.parent.parent;

      console.log(
        "start onUserCheckIn: providerId: " +
          providerId +
          " eventId: " +
          eventId +
          " userId: " +
          userId
      );

      //utente cancellato
      if (!snap.after.exists) {
        console.log("onUserCheckIn: utente rimosso da " + "eventId: " + userId);

        const previousUser: FirebaseFirestore.DocumentData | undefined =
          snap.before.data();

        if (previousUser != null) {
          const isGroup = previousUser.isGroup;

          //Decrementiamo il numero degli utenti totali
          const groupCount = isGroup ? previousUser.groupCount ?? 0 : 1;

          if (eventRef != null) {
            console.log(
              "onUserCheckIn: decrement total user with " + groupCount
            );
            await db.runTransaction(
              async (transaction: FirebaseFirestore.Transaction) => {
                await transaction.update(eventRef, {
                  totalUsers: firestore.FieldValue.increment(-groupCount),
                });
              }
            );
          }
        }
        return;
      }

      const user: FirebaseFirestore.DocumentData | undefined =
        snap.after.data();
      console.log(
        "onUserCheckIn: user check in name: " + user?.name + " " + user?.id
      );

      if (user === undefined || user === null) {
        console.log("onUserCheckIn: user id undefined ");
        return null;
      }

      const checkOutAt = user.checkOutAt;
      const checkInAt = user.checkInAt;
      const fromExternalOrganization = user.fromExternalOrganization;
      const isGroup = user.isGroup;

      // Nuovo utente (può avere checkInAt != null oppure checkOutAt != null mai entrambi != null)
      if (!snap.before.exists && snap.after.exists) {
        console.log("onUserCheckIn: new user in subevent " + sessionId);
        // Utente ha fatto check in
        if (checkInAt != null || checkOutAt != null) {
          console.log("onUserCheckIn: checkInAt or  checkOutAt != null");
          //Incrementiamo il numero degli utenti totali
          const groupCount = isGroup ? user.groupCount ?? 0 : 1;
          if (eventRef != null) {
            console.log("onUserCheckIn: eventRef : " + eventRef.path);
            console.log(
              "onUserCheckIn: increment total user with " + groupCount
            );
            await db.runTransaction(
              async (transaction: FirebaseFirestore.Transaction) => {
                await transaction.update(eventRef, {
                  totalUsers: firestore.FieldValue.increment(groupCount),
                });
              }
            );
          }
        }
      }

      //Se è un gruppo terminiamo la funzione in quanto i passaggi successivi sono relativi al rilascio dei wom
      if (isGroup) {
        console.log(
          "onUserCheckIn: The user is a group, a group will not receive woms"
        );
        return;
      }

      if (checkOutAt === undefined || checkOutAt === null) {
        console.log(
          "onUserCheckIn: Missing checkOut: this trigger need of checkOut date to release wom"
        );
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
      console.log("onUserCheckIn: eventName => " + eventName);

      if (womCount === undefined || womCount === null || womCount === 0) {
        console.log(
          "onUserCheckIn: this event not release wom to user : " + userId
        );
        return;
      }

      if (
        eventAccessType === "inOut" &&
        (checkInAt === undefined || checkInAt === null)
      ) {
        console.log(
          "onUserCheckIn: Event with in/out access must to have checkInAt defined"
        );
        return null;
      }

      let userData: any | undefined;

      // se il tesserino è di una organizzazione esterna (es: università)
      // prendo i dati direttamente dal doc del checkin/out
      if (fromExternalOrganization) {
        console.log("onUserCheckIn: tesserino di un organizzazione esterna");
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
        } else {
          console.log(
            "onUserCheckIn: parametro mancante nel documento del checkin/out "
          );
        }
      }

      if (!fromExternalOrganization && userData == null) {
        console.log("onUserCheckIn: tesserino da una organizzazione interna ");
        let ref = userDocRef(providerId, userId);
        const userDoc: FirebaseFirestore.DocumentData = await ref.get();

        userData = userDoc.data();

        if (!userDoc.exists || userData == null) {
          console.log("onUserCheckIn: user not exists on " + ref.path);
          return null;
        }

        console.log(userData);
      }

      const email = userData.email;
      if (email === undefined || email === null) {
        console.log("onUserCheckIn: STOP user not exist email undefined ");
        return null;
      }
      console.log("onUserCheckIn: user exist email " + userData.email);

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
        console.log(
          "onUserCheckIn: ApiKey is null or undefined, providerId: " +
            providerId
        );
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

exports.onGlobalPrivateUserCheckIn = functions
  .region("europe-west3")
  .firestore.document(
    "providers/{providerId}/events/{eventId}/privateUsers/{userId}"
  )
  .onWrite(async (snap, context) => {
    try {
      //const providerId = context.params.providerId;
      const userId = context.params.userId;

      //utente cancellato
      if (!snap.after.exists) {
        console.log(
          "onGlobalPrivateUserCheckIn: utente rimosso da " +
            "eventId: " +
            userId
        );
        return new Promise((resolve, reject) => {});
      }

      const privateEventUserData: FirebaseFirestore.DocumentData | undefined =
        snap.after.data();
      console.log(
        "onGlobalPrivateUserCheckIn: user check in private id: " +
          privateEventUserData?.id
      );

      if (privateEventUserData === undefined || privateEventUserData === null) {
        console.log(
          "onGlobalPrivateUserCheckIn: privateEventUserDoc undefined "
        );
        return new Promise((resolve, reject) => {});
      }

      const privateId = privateEventUserData.id;

      const privateUserDoc: FirebaseFirestore.DocumentData =
        await privateUserDocRef(privateId).get();

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
              console.log(
                "onGlobalPrivateUserCheckIn: Gender counter updated."
              );
            }
          }
        } else {
          console.log("onGlobalPrivateUserCheckIn: gender infot doesnt exists");
        }
      } else {
        console.log(
          "onGlobalPrivateUserCheckIn: private user doc doesnt exists"
        );
      }
      return new Promise((resolve, reject) => {});
    } catch (ex) {
      console.log("onGlobalPrivateUserCheckIn failed");
      console.log(ex);
      return new Promise((resolve, reject) => {});
    }
  });

export const onGlobalUserCheckIn = functions
  .region("europe-west3")
  .firestore.document("providers/{providerId}/events/{eventId}/users/{userId}")
  .onWrite(async (snap, context) => {
    try {
      const eventId = context.params.eventId;
      const providerId = context.params.providerId;
      const userId = context.params.userId;
      const eventRef = snap.after.ref.parent.parent;

      console.log(
        "onGlobalUserCheckIn: providerId" +
          providerId +
          " eventId: " +
          eventId +
          " userId: " +
          userId
      );

      //utente cancellato
      if (!snap.after.exists) {
        console.log(
          "onGlobalUserCheckIn: utente rimosso da " + "eventId: " + eventId,
          "userId: " + userId
        );

        const previousUser: FirebaseFirestore.DocumentData | undefined =
          snap.before.data();

        if (previousUser != null) {
          const isGroup = previousUser.isGroup;

          //Decrementiamo il numero degli utenti totali
          const groupCount = isGroup ? previousUser.groupCount ?? 0 : 1;
          if (eventRef != null) {
            console.log(
              "onGlobalUserCheckIn: decrement total user with " + groupCount
            );
            await db.runTransaction(
              async (transaction: FirebaseFirestore.Transaction) => {
                await transaction.update(eventRef, {
                  totalUsers: firestore.FieldValue.increment(-groupCount),
                });
              }
            );
          }
        }
        return new Promise((resolve, reject) => {});
      }

      const user: FirebaseFirestore.DocumentData | undefined =
        snap.after.data();
      console.log(
        "onGlobalUserCheckIn: user check in name: " +
          user?.name +
          " userId: " +
          user?.id
      );

      if (user === undefined || user === null) {
        console.log("onGlobalUserCheckIn: user is undefined ");
        return null;
      }

      //const checkOutAt = user.checkOutAt;
      //const checkInAt = user.checkInAt;
      const isGroup = user.isGroup;

      // Nuovo utente (può avere checkInAt != null oppure checkOutAt != null mai entrambi != null)
      if (!snap.before.exists && snap.after.exists) {
        // Utente ha fatto check in
        console.log("onGlobalUserCheckIn: check in global user " + user.id);
        //Incrementiamo il numero degli utenti totali
        const groupCount = isGroup ? user.groupCount ?? 0 : 1;
        if (eventRef != null) {
          console.log("onGlobalUserCheckIn: eventRef " + eventRef.path);
          console.log(
            "onGlobalUserCheckIn: increment total user with " + groupCount
          );
          return db.runTransaction(
            async (transaction: FirebaseFirestore.Transaction) => {
              await transaction.update(eventRef, {
                totalUsers: firestore.FieldValue.increment(groupCount),
              });
            }
          );
        }
      }
      return new Promise<void>(() => {
        //console.log("onGlobalUserCheckIn: end");
      }).then(() => {
        console.log("onGlobalUserCheckIn: end");
      });
    } catch (ex) {
      console.log("onGlobalUserCheckIn failed");
      console.log(ex);
      return null;
    }
  });
