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
    "providers/{providerId}/events/{eventId}/sessions/{sessionId}/privateUsers/{userDocId}"
  )
  .onWrite(async (snap, context) => {
    try {
      const userDocId = context.params.userDocId;

      //utente cancellato
      if (!snap.after.exists) {
        console.log(
          "onPrivateSessionUserCheckIn: utente rimosso da " +
            "eventId: " +
            userDocId
        );
        return;
      }

      const privateEventUserData: FirebaseFirestore.DocumentData | undefined =
        snap.after.data();
      console.log(
        "onPrivateSessionUserCheckIn: user check in private id: " +
          privateEventUserData?.id
      );

      if (privateEventUserData === undefined || privateEventUserData === null) {
        console.log(
          "onPrivateSessionUserCheckIn: privateEventUserDoc undefined "
        );
        return null;
      }

      const privateId = privateEventUserData.id;
      const genderWithoutCard = privateEventUserData.genderWithoutCard;

      const privateUserDoc: FirebaseFirestore.DocumentData =
        await privateUserDocRef(privateId).get();

      if (privateUserDoc.exists) {
        const userData = privateUserDoc.data();

        const gender = userData.gender;
        if (gender != null) {
          const countRef = snap.after.ref.parent.parent;
          if (countRef != null) {
            await updateGender(
              snap.after.exists,
              snap.before.exists,
              gender,
              countRef
            );
          }
        } else {
          console.log(
            "onPrivateSessionUserCheckIn: gender infot doesnt exists"
          );
        }
      } else if (genderWithoutCard != null) {
        console.log("onPrivateSessionUserCheckIn: gender from pocket scan");

        const countRef = snap.after.ref.parent.parent;
        if (countRef != null) {
          await updateGender(
            snap.after.exists,
            snap.before.exists,
            genderWithoutCard,
            countRef
          );
        }
      } else {
        console.log(
          "onPrivateSessionUserCheckIn: private user doc doesnt exists"
        );
      }
      return null;
    } catch (ex) {
      console.log("onPrivateSessionUserCheckIn failed");
      console.log(ex);
      return null;
    }
  });

async function updateGender(
  snapAfterExists: boolean,
  snapBeforeExists: boolean,
  gender: string,
  countRef: FirebaseFirestore.DocumentReference
) {
  let increment = 1;
  let m = 0;
  let f = 0;
  let nb = 0;
  let na = 0;
  if (snapAfterExists && !snapBeforeExists) {
    increment = 1;
  } else if (!snapAfterExists && snapBeforeExists) {
    increment = -1;
  }

  if (gender == "male") {
    m = increment;
  } else if (gender == "female") {
    f = increment;
  } else if (gender == "notBinary") {
    nb = increment;
  } else if (gender == "notAvailable") {
    na = increment;
  }

  if (m != 0 || f != 0 || nb != 0 || na != 0) {
    console.log(
      "updateGender: m: " + m + ",f: " + f + ",nb: " + nb + ",na: " + na
    );
    if (countRef != null) {
      await updateCounts(countRef, 1, m, f, nb, na);
      functions.logger.log("Gender counter updated.");
    }
  }
}

export const onSessionUserCheckIn = functions
  .region("europe-west3")
  .firestore.document(
    "providers/{providerId}/events/{eventId}/sessions/{sessionId}/users/{userDocId}"
  )
  .onWrite(async (snap, context) => {
    try {
      const eventId = context.params.eventId;
      const sessionId = context.params.sessionId;
      const providerId = context.params.providerId;
      const userDocId = context.params.userDocId;
      const eventRef = snap.after.ref.parent.parent;

      console.log(
        "start onSessionUserCheckIn: providerId: " +
          providerId +
          " eventId: " +
          eventId +
          " userId: " +
          userDocId
      );

      //utente cancellato
      if (!snap.after.exists) {
        console.log(
          "onSessionUserCheckIn: utente rimosso da " + "eventId: " + userDocId
        );

        const previousUser: FirebaseFirestore.DocumentData | undefined =
          snap.before.data();

        if (previousUser != null && eventRef != null) {
          await incrementUserCount(
            UpdateUserCount.decrement,
            eventRef,
            previousUser.isGroup,
            previousUser.hasPrivateInfo,
            previousUser.groupCount,
            previousUser.manPercentage,
            previousUser.womanPercentage
          );
        }
        return;
      }

      const user: FirebaseFirestore.DocumentData | undefined =
        snap.after.data();
      console.log(
        "onSessionUserCheckIn: user check in name: " +
          user?.name +
          " " +
          user?.id
      );

      if (user === undefined || user === null) {
        console.log("onSessionUserCheckIn: user id undefined ");
        return null;
      }

      const checkOutAt = user.checkOutAt;
      const checkInAt = user.checkInAt;
      const fromExternalOrganization = user.fromExternalOrganization;
      const isGroup = user.isGroup;

      // Nuovo utente (può avere checkInAt != null oppure checkOutAt != null mai entrambi != null)
      if (!snap.before.exists && snap.after.exists) {
        console.log("onSessionUserCheckIn: new user in subevent " + sessionId);
        // Utente ha fatto check in
        if (checkInAt != null || checkOutAt != null) {
          console.log("onSessionUserCheckIn: checkInAt or  checkOutAt != null");

          if (eventRef != null) {
            await incrementUserCount(
              UpdateUserCount.increment,
              eventRef,
              user.isGroup,
              user.hasPrivateInfo,
              user.groupCount,
              user.manPercentage,
              user.womanPercentage
            );
          }
        }
      }

      //Se è un gruppo terminiamo la funzione in quanto i passaggi successivi sono relativi al rilascio dei wom
      if (isGroup) {
        console.log(
          "onSessionUserCheckIn: The user is a group, a group will not receive woms"
        );
        return;
      }

      if (checkOutAt === undefined || checkOutAt === null) {
        console.log(
          "onSessionUserCheckIn: Missing checkOut: this trigger need of checkOut date to release wom"
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
      console.log("onSessionUserCheckIn: eventName => " + eventName);

      if (womCount === undefined || womCount === null || womCount === 0) {
        console.log(
          "onSessionUserCheckIn: this event not release wom to user : " +
            userDocId
        );
        return;
      }

      if (
        eventAccessType === "inOut" &&
        (checkInAt === undefined || checkInAt === null)
      ) {
        console.log(
          "onSessionUserCheckIn: Event with in/out access must to have checkInAt defined"
        );
        return null;
      }

      let userData: any | undefined;

      // se il tesserino è di una organizzazione esterna (es: università)
      // prendo i dati direttamente dal doc del checkin/out
      if (fromExternalOrganization) {
        console.log(
          "onSessionUserCheckIn: tesserino di un organizzazione esterna"
        );
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
            "onSessionUserCheckIn: parametro mancante nel documento del checkin/out "
          );
        }
      }

      if (!fromExternalOrganization && userData == null) {
        console.log(
          "onSessionUserCheckIn: tesserino da una organizzazione interna "
        );
        let ref = userDocRef(user.providerId, user.id);
        const userDoc: FirebaseFirestore.DocumentData = await ref.get();

        userData = userDoc.data();

        if (!userDoc.exists || userData == null) {
          console.log("onSessionUserCheckIn: user not exists on " + ref.path);
          return null;
        }

        console.log(userData);
      }

      const email = userData.email;
      if (email === undefined || email === null) {
        console.log(
          "onSessionUserCheckIn: STOP user not exist email undefined "
        );
        return null;
      }
      console.log("onSessionUserCheckIn: user exist email " + userData.email);

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
          "onSessionUserCheckIn: ApiKey is null or undefined, providerId: " +
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
      console.log("onSessionUserCheckIn failed");
      console.log(ex);
      return null;
    }
  });

exports.onGlobalPrivateUserCheckIn = functions
  .region("europe-west3")
  .firestore.document(
    "providers/{providerId}/events/{eventId}/privateUsers/{userDocId}"
  )
  .onWrite(async (snap, context) => {
    try {
      const userDocId = context.params.userDocId;

      //utente cancellato
      if (!snap.after.exists) {
        console.log(
          "onGlobalPrivateUserCheckIn: utente rimosso da " +
            "eventId: " +
            userDocId
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
      const genderWithoutCard = privateEventUserData.genderWithoutCard;

      const privateUserDoc: FirebaseFirestore.DocumentData =
        await privateUserDocRef(privateId).get();

      if (privateUserDoc.exists) {
        const userData = privateUserDoc.data();

        const gender = userData.gender;
        if (gender != null) {
          const countRef = snap.after.ref.parent.parent;
          if (countRef != null) {
            await updateGender(
              snap.after.exists,
              snap.before.exists,
              gender,
              countRef
            );
          }
        } else {
          console.log("onGlobalPrivateUserCheckIn: gender infot doesnt exists");
        }
      } else if (genderWithoutCard != null) {
        console.log("onPrivateSessionUserCheckIn: gender from pocket scan");

        const countRef = snap.after.ref.parent.parent;
        if (countRef != null) {
          await updateGender(
            snap.after.exists,
            snap.before.exists,
            genderWithoutCard,
            countRef
          );
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
  .firestore.document(
    "providers/{providerId}/events/{eventId}/users/{userDocId}"
  )
  .onWrite(async (snap, context) => {
    try {
      const eventId = context.params.eventId;
      const providerId = context.params.providerId;
      const userDocId = context.params.userDocId;
      const eventRef = snap.after.ref.parent.parent;

      console.log(
        "onGlobalUserCheckIn: providerId" +
          providerId +
          " eventId: " +
          eventId +
          " userId: " +
          userDocId
      );

      //utente cancellato
      if (!snap.after.exists) {
        console.log(
          "onGlobalUserCheckIn: utente rimosso da " + "eventId: " + eventId,
          "userId: " + userDocId
        );

        const previousUser: FirebaseFirestore.DocumentData | undefined =
          snap.before.data();

        if (previousUser != null && eventRef != null) {
          await incrementUserCount(
            UpdateUserCount.decrement,
            eventRef,
            previousUser.isGroup,
            previousUser.hasPrivateInfo,
            previousUser.groupCount,
            previousUser.manPercentage,
            previousUser.womanPercentage
          );
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

      // Nuovo utente (può avere checkInAt != null oppure checkOutAt != null mai entrambi != null)
      if (!snap.before.exists && snap.after.exists) {
        // Utente ha fatto check in
        console.log("onGlobalUserCheckIn: check in global user " + user.id);

        if (eventRef != null) {
          return incrementUserCount(
            UpdateUserCount.increment,
            eventRef,
            user.isGroup,
            user.hasPrivateInfo,
            user.groupCount,
            user.manPercentage,
            user.womanPercentage
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

async function updateCounts(
  reference: FirebaseFirestore.DocumentReference,
  totalUser: number,
  manCount: number,
  womanCount: number,
  notBinary: number,
  notAvailable: number
) {
  console.log("updateCounts");
  console.log(reference.path);
  console.log(
    "totalUsers: " +
      totalUser +
      ", male: " +
      manCount +
      ", famale: " +
      womanCount +
      ", notBinary: " +
      notBinary +
      ", notAvailable: " +
      notAvailable
  );
  return db.runTransaction(
    async (transaction: FirebaseFirestore.Transaction) => {
      await transaction.update(reference, {
        totalUsers: firestore.FieldValue.increment(totalUser),
        "genderCount.male": firestore.FieldValue.increment(manCount),
        "genderCount.female": firestore.FieldValue.increment(womanCount),
        "genderCount.notBinary": firestore.FieldValue.increment(notBinary),
        "genderCount.notAvailable":
          firestore.FieldValue.increment(notAvailable),
      });
    }
  );
}

enum UpdateUserCount {
  increment,
  decrement,
}

// Usata per incrementare/decrementare i contatori di di gruppi e utenti senza riferimento al genere
async function incrementUserCount(
  type: UpdateUserCount,
  eventRef: FirebaseFirestore.DocumentReference,
  isGroup: boolean,
  hasPrivateInfo: boolean,
  groupCount: number,
  manPercentage: number,
  womanPercentage: number
) {
  console.log("incrementUserCount");
  //Incrementiamo il numero degli utenti totali
  const totalUsers = isGroup ? groupCount ?? 0 : hasPrivateInfo ?? true ? 0 : 1;
  let man: number = 0;
  let woman: number = 0;
  let notAvailable: number = 0;
  if (isGroup && manPercentage != null && womanPercentage != null) {
    man = Math.round(groupCount * manPercentage);
    woman = Math.round(groupCount * womanPercentage);
  } else {
    notAvailable = totalUsers;
  }
  if (man == 0 && woman == 0 && notAvailable == 0 && totalUsers == 0) {
    return;
  }

  if (type == UpdateUserCount.increment) {
    return updateCounts(eventRef, totalUsers, man, woman, 0, notAvailable);
  }
  return updateCounts(eventRef, -totalUsers, -man, -woman, 0, -notAvailable);
}
