import * as functions from "firebase-functions";
import * as dotenv from "dotenv";
dotenv.config();
import * as firestore from "@google-cloud/firestore";
const cors = require("cors")({ origin: true });
import {
  eventDocRef,
  providerDocRef,
  sessionDocRef,
  totemDocRef,
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
        const eventId = data.eventId;
        const requestId = data.requestId;
        const totemId = data.totemId;
        const userLat = data.latitude;
        const userLong = data.longitude;

        const now = new Date();
        //const timestamp = new Date(data.timestamp);
        //const firestoreTimestamp = firestore.Timestamp.fromDate(timestamp);

        if (
          providerId == null ||
          eventId == null ||
          totemId == null ||
          requestId == null ||
          userLat == null ||
          userLong == null
        ) {
          response.status(400).send("some body fields are null");
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
          response.status(400).send("activeSessionId null");
          return;
        }

        const sessionId = eventData.activeSessionId;
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
        const endAt = sessionData.endAt.toDate();

        const isExpired = now.getTime() - endAt.getTime() > 0;
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

        const totemRef = totemDocRef(providerId, eventId, totemId);
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

        // Check requestId on doc
        if (requestId != totemData.requestId) {
          response.status(200).send({
            status: "wrongRequestId",
            sessionId: sessionId,
          });
          return;
        }

        // Update requestId on doc
        totemRef.update({
          count: totemData.count + 1,
          requestId: generateSecret(),
          updatedOn: firestore.Timestamp.fromDate(now),
        });

        // check position
        const latitude = totemData.position.latitude;
        const longitude = totemData.position.longitude;
        const radius = totemData.radius;
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

        // generate wom
        const providerDoc: FirebaseFirestore.DocumentData =
          await providerDocRef(providerId).get();

        const apiKey = providerDoc.data().apiKey;
        const aim = providerDoc.data().aim;
        const wom = await generateWom(apiKey, 1, aim);
        response.status(200).send({
          status: "success",
          link: wom.link,
          pin: wom.pin,
          sessionId: sessionId,
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
