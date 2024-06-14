import * as functions from "firebase-functions";
import * as dotenv from "dotenv";
dotenv.config();
const admin = require("firebase-admin");
const db = admin.firestore();
import * as firestore from "@google-cloud/firestore";
const cors = require("cors")({ origin: true });
import {
  eventDocRef,
  eventPrivateUsersCollection,
  eventPrivateUsersDoc,
  providerDocRef,
  providerTotemDocRef,
  sessionDocRef,
  sessionPrivateUsersDoc,
  sessionsCollection,
} from "./firestore_references";
import { generateSecret, generateWom } from "./utils";
const circleToPolygon = require("circle-to-polygon");

export const scan = functions
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
        const lastSessionIdScanned = data.lastSessionIdScanned;
        const participationCount = data.participationCount;
        const requestId = data.requestId;
        const totemId = data.totemId;
        const userLat: number = data.latitude;
        const userLong: number = data.longitude;
        const gender = data.gender;

        const now = new Date();

        if (
          providerId == null ||
          totemId == null ||
          userLat == null ||
          userLong == null
        ) {
          response.status(400).send("some body fields are null");
          return;
        }

        const totemRef = providerTotemDocRef(providerId, totemId);
        const totemDoc = await totemRef.get();

        if (!totemDoc.exists) {
          response
            .status(400)
            .send("totemData document doesn't exists, " + totemRef.path);
          return;
        }

        const totemData = totemDoc.data();

        if (totemData == null) {
          response.status(400).send("totemData is null, " + totemRef.path);
          return;
        }

        const eventId = totemData.eventId;
        const sessionId = totemData.sessionId;

        if (eventId == null || sessionId == null) {
          response.status(200).send({
            status: "totemDisabled",
            message: "eventId or sessionId is missing",
          });
          return;
        }

        const eventRef = eventDocRef(providerId, eventId);
        const eventDoc = await eventRef.get();
        const eventData = eventDoc.data();

        if (!eventDoc.exists || eventData == null) {
          response
            .status(400)
            .send("eventData document doesn't exists, " + eventRef.path);
          return;
        }

        if (eventData.activeSessionId == null) {
          response.status(200).send({
            status: "eventIsClosed",
          });
          return;
        }

        if (eventData.maxWomCount == null || eventData.maxWomCount == 0) {
          response.status(200).send({
            status: "noWomForThisEvent",
          });
          return;
        }

        if (eventData.activeSessionId != sessionId) {
          response
            .status(400)
            .send(
              "event activeSessionId " +
                eventData.activeSessionId +
                " is not equal to totem sessionId " +
                sessionId
            );
          return;
        }

        if (lastSessionIdScanned == sessionId) {
          response.status(200).send({
            status: "sessionAlreadyScanned",
            sessionId: sessionId,
          });
          return;
        }

        // Check static or dynamic totem
        if (!totemData.isStatic) {
          if (requestId == null) {
            response.status(200).send({
              status: "dynamicTotemNeedRequestId",
              sessionId: sessionId,
            });
            return;
          } else if (requestId != totemData.requestId) {
            // Check requestId on doc
            response.status(200).send({
              status: "wrongRequestId",
              sessionId: sessionId,
            });
            return;
          }
        }

        // Update requestId on doc and totalCount
        totemRef.update({
          totalCount: firestore.FieldValue.increment(1),
          requestId: totemData.isStatic ? null : generateSecret(),
          updatedOn: firestore.Timestamp.fromDate(now),
        });

        const sessionRef = sessionDocRef(providerId, eventId, sessionId);
        const sessionDoc = await sessionRef.get();
        const sessionData = sessionDoc.data();

        if (!sessionDoc.exists || sessionData == null) {
          response
            .status(400)
            .send("sessionData document doesn't exists, " + sessionRef.path);
          return;
        }

        const startAt = sessionData.startAt.toDate();

        // endAt can be null if the event has manual session opening
        const endAt = sessionData.endAt?.toDate();

        const isExpired =
          endAt == null ? false : now.getTime() - endAt.getTime() > 0;
        const isStarted = now.getTime() - startAt.getTime() > 0;

        if (isExpired) {
          response.status(200).send({
            status: "sessionExpired",
            sessionId: sessionId,
          });
          return;
        }

        if (!isStarted) {
          response.status(200).send({
            status: "sessionNotStarted",
            sessionId: sessionId,
          });
          return;
        }

        // check position
        const latitude = totemData.position?.latitude;
        const longitude = totemData.position?.longitude;
        const radius = totemData.radius;

        if (latitude != null && longitude != null) {
          const coordinates = [longitude, latitude]; //[lon, lat]
          const userCoordinates = [userLong, userLat];
          const numberOfEdges = 32;

          let polygon = circleToPolygon(coordinates, radius, numberOfEdges);
          const isInside = getIsPointInsidePolygon(
            userCoordinates,
            polygon.coordinates[0]
          );

          console.log("isInside2: " + isInside);
          if (!isInside) {
            response.status(200).send({
              status: "outOfPolygon",
              sessionId: sessionId,
              polygon: polygon.coordinates[0],
            });
            return;
          }
        }

        // Update effective count
        totemRef.update({
          count: firestore.FieldValue.increment(1),
          updatedOn: firestore.Timestamp.fromDate(now),
        });

        const batch = db.batch();
        const userSubEventDocRef = sessionDocRef(providerId, eventId, sessionId)
          .collection("users")
          .doc();

        const userId = userSubEventDocRef.id;

        const json = {
          totemId: totemData.id,
          position: new firestore.GeoPoint(userLat, userLong),
          isGroup: false,
          id: userId,
          name: "Utente anonimo",
          surname: "",
          cf: "",
          fromExternalOrganization: false,
          privateId: null,
          isAnonymous: true,
          providerId: providerId,
          checkOutAt: firestore.Timestamp.fromDate(now),
          hasPrivateInfo: gender != null,
          participationCount: participationCount ?? 1,
        };

        batch.set(userSubEventDocRef, json);

        let privateId: string | null = null;
        // se c'è il genere allora salviamo l utente con info private
        if (gender != null) {
          const privateRef = eventPrivateUsersCollection(providerId, eventId);
          const docRef = privateRef.doc();
          privateId = docRef.id;
          batch.set(
            sessionPrivateUsersDoc(providerId, eventId, sessionId, privateId),
            {
              id: privateId,
              genderWithoutCard: gender,
            }
          );
        }

        // se prima scansiona per questo evento salviamo l utente unico
        if (lastSessionIdScanned == null) {
          const globalUserRef = eventDocRef(providerId, eventId)
            .collection("users")
            .doc(userId);

          batch.set(globalUserRef, json);

          if (privateId != null) {
            batch.set(eventPrivateUsersDoc(providerId, eventId, privateId), {
              id: privateId,
              genderWithoutCard: gender,
            });
          }
        }

        batch.commit();

        // generate wom
        const providerDoc: FirebaseFirestore.DocumentData =
          await providerDocRef(providerId).get();
        const providerData = providerDoc.data();

        const apiKey = providerData.apiKey;
        const aim = eventData.aim ?? providerData.aim;
        const wom = await generateWom(
          apiKey,
          eventData.maxWomCount,
          aim,
          userLat,
          userLong
        );

        response.status(200).send({
          status: "success",
          link: wom.link,
          pin: wom.pin,
          aim: aim,
          eventId: eventId,
          sessionId: sessionId,
        });
      });
    }
  );

export const verifyTotem = functions
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
        const totemId = data.totemId;

        if (providerId == null || totemId == null) {
          response.status(400).send("some body fields are null");
          return;
        }

        const totemRef = providerTotemDocRef(providerId, totemId);
        const totemDoc = await totemRef.get();

        if (!totemDoc.exists) {
          response
            .status(400)
            .send("totemData document doesn't exists, " + totemRef.path);
          return;
        }

        const totemData = totemDoc.data();

        if (totemData == null) {
          response.status(400).send("totemData is null, " + totemRef.path);
          return;
        }

        console.log(totemData);
        const eventId = totemData.eventId;
        const sessionId = totemData.sessionId;
        const dedicated = totemData.dedicated;

        if (eventId == null || sessionId == null) {
          response.status(200).send({
            status: "totemDisabled",
            message: "eventId or sessionId is missing",
          });
          return;
        }

        response.status(200).send({
          status: "success",
          eventId: eventId,
          sessionId: sessionId,
          dedicated: dedicated,
        });
      });
    }
  );

export const scan2 = functions
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
        const totemId = data.totemId;
        const requestId = data.requestId;

        // Pocket data
        const userLat: number = data.latitude;
        const userLong: number = data.longitude;
        const gender = data.gender;
        const scannedSessions = data.sessions;
        const lastSessionIdScanned = data.lastSessionIdScanned;
        const eventParticipationCount = data.eventParticipationCount;

        const v1 = scannedSessions != null;
        const v2 = scannedSessions == null;

        const now = new Date();

        if (
          providerId == null ||
          totemId == null ||
          userLat == null ||
          userLong == null
        ) {
          response.status(400).send("some body fields are null");
          return;
        }

        const totemRef = providerTotemDocRef(providerId, totemId);
        const totemDoc = await totemRef.get();

        if (!totemDoc.exists) {
          response
            .status(400)
            .send("totemData document doesn't exists, " + totemRef.path);
          return;
        }

        const totemData = totemDoc.data();

        if (totemData == null) {
          response.status(400).send("totemData is null, " + totemRef.path);
          return;
        }

        console.log(totemData);
        const eventId = totemData.eventId;
        const sessionId = totemData.sessionId;
        const dedicated = totemData.dedicated;

        if (eventId == null || sessionId == null) {
          response.status(200).send({
            status: "totemDisabled",
            message: "eventId or sessionId is missing",
          });
          return;
        }

        const eventRef = eventDocRef(providerId, eventId);
        const eventDoc = await eventRef.get();
        const eventData = eventDoc.data();

        if (!eventDoc.exists || eventData == null) {
          response
            .status(400)
            .send("eventData document doesn't exists, " + eventRef.path);
          return;
        }

        if (eventData.activeSessionId == null) {
          response.status(200).send({
            status: "eventIsClosed",
          });
          return;
        }

        if (!dedicated && eventData.activeSessionId != sessionId) {
          const message =
            "event activeSessionId " +
            eventData.activeSessionId +
            " is not equal to totem sessionId " +
            sessionId;
          console.log(message);
          response.status(200).send({
            status: "totemSessionInactive",
            sessionId: eventData.activeSessionId,
          });
          return;
        }

        if (eventData.maxWomCount == null || eventData.maxWomCount == 0) {
          response.status(200).send({
            status: "noWomForThisEvent",
          });
          return;
        }

        if (
          (lastSessionIdScanned != null &&
            lastSessionIdScanned == eventData.activeSessionId) ||
          (v1 && scannedSessions[eventData.activeSessionId] != null)
        ) {
          response.status(200).send({
            status: "sessionAlreadyScanned",
            sessionId: eventData.activeSessionId,
          });
          return;
        }

        // Check static or dynamic totem
        if (!totemData.isStatic) {
          if (requestId == null) {
            response.status(200).send({
              status: "dynamicTotemNeedRequestId",
              sessionId: eventData.activeSessionId,
            });
            return;
          } else if (requestId != totemData.requestId) {
            // Check requestId on doc
            response.status(200).send({
              status: "wrongRequestId",
              sessionId: eventData.activeSessionId,
            });
            return;
          }
        }

        // Update requestId on doc and totalCount
        totemRef.update({
          totalCount: firestore.FieldValue.increment(1),
          requestId: totemData.isStatic ? null : generateSecret(),
          updatedOn: firestore.Timestamp.fromDate(now),
        });

        const sessionRef = sessionDocRef(
          providerId,
          eventId,
          eventData.activeSessionId
        );
        const sessionDoc = await sessionRef.get();
        const sessionData = sessionDoc.data();

        if (!sessionDoc.exists || sessionData == null) {
          response
            .status(400)
            .send("sessionData document doesn't exists, " + sessionRef.path);
          return;
        }

        const startAt = sessionData.startAt.toDate();

        // endAt can be null if the event has manual session opening
        const endAt = sessionData.endAt?.toDate();

        const isExpired =
          endAt == null ? false : now.getTime() - endAt.getTime() > 0;
        const isStarted = now.getTime() - startAt.getTime() > 0;

        if (isExpired) {
          response.status(200).send({
            status: "sessionExpired",
            eventId: eventId,
            eventName: eventData.name,
            sessionId: eventData.activeSessionId,
            sessionName: sessionData.name,
            totemName: totemData.name,
          });
          return;
        }

        if (!isStarted) {
          response.status(200).send({
            status: "sessionNotStarted",
            eventId: eventId,
            eventName: eventData.name,
            sessionId: eventData.activeSessionId,
            sessionName: sessionData.name,
            totemName: totemData.name,
          });
          return;
        }

        // check position
        const latitude = totemData.position?.latitude;
        const longitude = totemData.position?.longitude;
        const radius = totemData.radius;

        if (latitude != null && longitude != null) {
          const coordinates = [longitude, latitude]; //[lon, lat]
          const userCoordinates = [userLong, userLat];
          const numberOfEdges = 32;

          let polygon = circleToPolygon(coordinates, radius, numberOfEdges);
          const isInside = getIsPointInsidePolygon(
            userCoordinates,
            polygon.coordinates[0]
          );

          console.log("isInside2: " + isInside);
          if (!isInside) {
            response.status(200).send({
              status: "outOfPolygon",
              polygon: polygon.coordinates[0],
              eventId: eventId,
              eventName: eventData.name,
              sessionId: eventData.activeSessionId,
              sessionName: sessionData.name,
              totemName: totemData.name,
            });
            return;
          }
        }

        // Update effective count
        totemRef.update({
          count: firestore.FieldValue.increment(1),
          updatedOn: firestore.Timestamp.fromDate(now),
        });

        const batch = db.batch();
        const userSubEventDocRef = sessionDocRef(
          providerId,
          eventId,
          eventData.activeSessionId
        )
          .collection("users")
          .doc();

        const userId = userSubEventDocRef.id;

        const participationCount =
          eventParticipationCount != null ? eventParticipationCount : 1;

        const json = {
          totemId: totemData.id,
          position: new firestore.GeoPoint(userLat, userLong),
          isGroup: false,
          id: userId,
          name: "Utente anonimo",
          surname: "",
          cf: "",
          fromExternalOrganization: false,
          privateId: null,
          isAnonymous: true,
          providerId: providerId,
          checkOutAt: firestore.Timestamp.fromDate(now),
          hasPrivateInfo: gender != null,
          participationCount: participationCount,
        };

        batch.set(userSubEventDocRef, json);

        let privateId: string | null = null;
        // se c'è il genere allora salviamo l utente con info private
        if (gender != null) {
          const privateRef = eventPrivateUsersCollection(providerId, eventId);
          const docRef = privateRef.doc();
          privateId = docRef.id;
          batch.set(
            sessionPrivateUsersDoc(
              providerId,
              eventId,
              eventData.activeSessionId,
              privateId
            ),
            {
              id: privateId,
              genderWithoutCard: gender,
            }
          );
        }

        // se prima scansiona per questo evento salviamo l utente unico
        if (
          (v1 && scannedSessions[eventData.activeSessionId] == null) ||
          (v2 && lastSessionIdScanned == null)
        ) {
          const globalUserRef = eventDocRef(providerId, eventId)
            .collection("users")
            .doc(userId);

          batch.set(globalUserRef, json);

          if (privateId != null) {
            batch.set(eventPrivateUsersDoc(providerId, eventId, privateId), {
              id: privateId,
              genderWithoutCard: gender,
            });
          }
        }

        batch.commit();

        // generate wom
        const providerDoc: FirebaseFirestore.DocumentData =
          await providerDocRef(providerId).get();
        const providerData = providerDoc.data();

        const apiKey = providerData.apiKey;
        const aim = eventData.aim ?? providerData.aim;
        const wom = await generateWom(
          apiKey,
          eventData.maxWomCount,
          aim,
          userLat,
          userLong
        );

        response.status(200).send({
          status: "success",
          link: wom.link,
          pin: wom.pin,
          aim: aim,
          eventId: eventId,
          eventName: eventData.name,
          sessionId: eventData.activeSessionId,
          sessionName: sessionData.name,
          totemName: totemData.name,
        });
      });
    }
  );

const getIsPointInsidePolygon = (point: number[], vertices: number[][]) => {
  const x = point[0];
  const y = point[1];

  let inside = false;
  for (let i = 0, j = vertices.length - 1; i < vertices.length; j = i++) {
    const xi = vertices[i][0],
      yi = vertices[i][1];
    const xj = vertices[j][0],
      yj = vertices[j][1];

    const intersect =
      yi > y != yj > y && x < ((xj - xi) * (y - yi)) / (yj - yi) + xi;
    if (intersect) inside = !inside;
  }

  return inside;
};
/*
export const moveTotems = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      cors(request, response, async () => {
        console.log(request.body);

        if (request.method !== "GET") {
          response.status(403).send("Forbidden!");
          return;
        }

        let ob = {};
        const batch = db.batch();
        const providers = await providersCollectionRef().get();
        for (let index = 0; index < providers.docs.length; index++) {
          const provider = providers.docs[index].data();
          console.log(provider.name);

          const events = await eventCollectionRef(provider.id).get();
          for (let k = 0; k < events.docs.length; k++) {
            const event = events.docs[k].data();

            const totems = await totemCollectionRef(
              provider.id,
              event.id
            ).get();

            for (let i = 0; i < totems.docs.length; i++) {
              const t = totems.docs[i].data();
              ob = {
                ...t,
                eventId: event.id,
                sessionId: event.activeSessionId,
                dedicated: true,
              };
              console.log(ob);
              batch.set(providerTotemDocRef(provider.id, t.id), ob);
            }
          }
        }

        await batch.commit();
        response.send({
          providers: providers.docs.length,
          totem: ob,
        });
      });
    }
  );
*/
