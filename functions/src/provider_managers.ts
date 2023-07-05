import * as functions from "firebase-functions";
const admin = require("firebase-admin");
const db = admin.firestore();
import Email = require("./email");
//const bodyParser = require("body-parser");
import * as dotenv from "dotenv";
dotenv.config();
const cors = require("cors")({ origin: true });
import * as utils from "./firestore_utils";
import { createNewAdminForProvider, generateSecret } from "./utils";
import {
  providerDocRef,
  providerPendingInviteDocRef,
} from "./firestore_references";

// Api invocata dal client per confermare un invito a collaborare
export const confirmPendingInvite = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        if (request.method !== "POST") {
          response.status(403).send("Forbidden!");
          return;
        }

        console.log("confirmPendingInvite");
        const data = request.body;
        const inviteId: string = data.inviteId;
        const secret = data.secret;
        const providerId: string = data.providerId;

        if (
          inviteId === undefined ||
          inviteId === null ||
          providerId === undefined ||
          providerId === null ||
          secret === undefined ||
          secret === null
        ) {
          throw new functions.https.HttpsError(
            "invalid-argument",
            "inviteId: " +
              inviteId +
              " secret: " +
              secret +
              " providerId: " +
              providerId
          );
        }

        console.log("confirmPendingInvite: arguments ok");
        const invite = await providerPendingInviteDocRef(
          providerId,
          inviteId
        ).get();

        const inviteData = invite.data();
        if (!invite.exists || inviteData == null) {
          throw new functions.https.HttpsError(
            "invalid-argument",
            "pending invite data doesn't exists"
          );
        }

        const status = inviteData.status;
        if (status === "completed") {
          response
            .send({
              status: "alreadyConfirmed",
            })
            .end();
          return;
        } else if (status === "deleted") {
          response
            .send({
              status: "deletedFromOwner",
            })
            .end();
          return;
        }

        console.log(inviteData);

        const secretOnDb = inviteData.secret;
        const email = inviteData.email;
        var fullName = inviteData.name;
        const role: string = inviteData.role;

        if (secretOnDb !== secret) {
          console.log("invite secret: " + secretOnDb + " != " + secret);
          throw new functions.https.HttpsError(
            "permission-denied",
            "The secret is different!"
          );
        }

        console.log("confirmPendingInvite: secret ok");
        var userId = inviteData.userId;
        const name = data.name;
        const surname = data.surname;
        var cf = data.cf;

        // Create New user
        if (userId === undefined || userId === null) {
          console.log("confirmPendingInvite: new user");
          if (
            name === undefined ||
            name === null ||
            surname === undefined ||
            surname === null ||
            cf === undefined ||
            cf === null
          ) {
            throw new functions.https.HttpsError(
              "invalid-argument",
              "name: " + name + " surname: " + surname + " cf: " + cf
            );
          }
          fullName = name + " " + surname;

          const tmpUser = await createNewAdminForProvider(
            name,
            surname,
            email,
            role,
            providerId,
            cf
          );
          userId = tmpUser.uid;
        } else {
          console.log(
            "get existing user " + userId + " of provider " + providerId
          );
          const userData = await utils.getManagerUserData(userId);
          fullName = userData.name + " " + userData.surname;
          console.log("user retrieved " + fullName);
        }

        //TODO  controlla che l utente esista veramente

        // leggo il provider con transaction
        try {
          await db.runTransaction(async (t: FirebaseFirestore.Transaction) => {
            const sfDoc = await t.get(providerDocRef(providerId));
            const providerData = sfDoc.data();
            if (!sfDoc.exists || providerData == null) {
              throw "Provider Document does not exists: " + providerId;
            }

            const eventsRestriction: Array<string> =
              inviteData.eventsRestriction;

            // controllo managers
            console.log("providerData: " + providerData.id);
            const currentManagers = providerData.managers;

            const transformedTokensMap = new Map<string, any>();
            Object.keys(currentManagers).forEach((e) => {
              transformedTokensMap.set(e, currentManagers[e]);
            });

            var map: Object = {};

            // se esisto aggiungo evento alla restrizione
            if (transformedTokensMap.has(userId) && role == "scanner") {
              console.log("current managers has userId: " + userId);
              const m = transformedTokensMap.get(userId);
              console.log("manage map + " + m);
              const r: Array<string> = m.eventsRestriction;

              console.log("current event restriction: " + r);
              console.log("new event restriction: " + eventsRestriction[0]);
              if (eventsRestriction.length > 0) {
                r.push(eventsRestriction[0]);
              }

              map = {
                id: m.id,
                role: m.role,
                email: m.email,
                name: m.name,
                eventsRestriction: r,
              };
            } else {
              // else creo l utente in managers
              map = {
                id: userId,
                role: role,
                email: email,
                name: fullName,
                eventsRestriction: eventsRestriction,
              };
            }

            console.log("new map: " + map);

            let managers = new Map<string, Object>();
            managers.set("managers." + userId, map);
            let jManagers = Object.fromEntries(managers);

            console.log("updating managers");

            console.log(jManagers);

            t.update(providerDocRef(providerId), jManagers);
            t.update(providerPendingInviteDocRef(providerId, inviteId), {
              status: "completed",
            });
          });
          console.log("Transaction successfully committed!");

          await Email.sendWelcomeNewProvider(
            inviteData.providerName,
            email,
            fullName,
            role
          );
          response
            .send({
              status: "completed",
            })
            .end();
        } catch (ex) {
          console.log("Transaction failed!");
          console.log(ex);

          response.status(500).send(ex);
        }

        //let map = new Map<string, string>();
        //map.set("providersRole." + invite.userId, role);
        //let jsonObject = Object.fromEntries(map);

        /*return db
        .doc("credentials" + "/" + invite.userId)
        .update(jsonObject)
        .then(() => {
          return {
            status: "completed",
          };
        });*/
      });
    }
  );

// Aggiorna il documento dell invito con un secret (generato lato server)
// e lo userId se l utente è già registrato poi invia l email all utente
// con lo url per confermare l invito
export const onInviteToCollaborate = functions
  .region("europe-west3")
  .firestore.document("providers/{providerId}/pendingInvite/{inviteId}")
  .onCreate(async (snap, context) => {
    const inviteId = context.params.inviteId;
    const providerId = context.params.providerId;
    const invite: FirebaseFirestore.DocumentData = snap.data();

    const role = invite.role;
    const email = invite.email;
    const providerName = invite.providerName;
    const fullName = invite.name;
    console.log(
      "new invite to collaborate " +
        providerName +
        " " +
        fullName +
        " " +
        role +
        " " +
        email
    );

    // TODO check that all field is valid

    const requestRef = providerPendingInviteDocRef(providerId, inviteId);
    var secret = generateSecret();

    await requestRef.update({
      secret: secret,
    });

    var url: string =
      "https://cmi.digit.srl/confirmInvite?i=" +
      inviteId +
      "&s=" +
      secret +
      "&p=" +
      providerId +
      "&n=" +
      providerName;

    try {
      const user = await admin.auth().getUserByEmail(email);
      await requestRef.update({
        userId: user.uid,
      });
      url = url + "&u=" + user.uid;
      console.log("user exist");
    } catch (err) {
      console.log(err);
      //if (err.code === "auth/user-not-found") {
      // User doesn't exist yet, create it...
      // }
    }

    console.log(url);
    return Email.sendInvite(providerName, fullName, email, role, url);
  });
