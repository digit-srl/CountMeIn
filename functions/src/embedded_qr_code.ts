import * as functions from "firebase-functions";
//const admin = require("firebase-admin");
import * as dotenv from "dotenv";
dotenv.config();
//const db = admin.firestore();
//const cors = require("cors")({ origin: true });
import * as firestore from "@google-cloud/firestore";
const cors = require("cors")({ origin: true });
import { totemDocRef, providerDocRef } from "./firestore_references";
import { generateSecret, generateWom } from "./utils";

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
        const eventId = data.eventId;
        const providerId = data.providerId;
        const totemId = data.totemId;
        //const lat = data.latitude;
        //const long = data.longitude

        //const timestamp = new Date(data.timestamp);
        //const firestoreTimestamp = firestore.Timestamp.fromDate(timestamp);

        if (providerId == null || eventId == null || totemId == null) {
          response.status(400).send("invalid providerId or eventId or totemId");
          return;
        }

        const totemRef = totemDocRef(providerId, eventId, totemId);
        const eventDoc = await totemRef.get();

        if (!eventDoc.exists) {
          response.status(400).send("totemData is null, " + totemRef.path);
          return;
        }

        const totemData = eventDoc.data();

        if (totemData == null) {
          response.status(400).send("totemData is null, " + totemRef.path);
          return;
        }

        // update QR on doc
        totemRef.update({
          count: totemData.count + 1,
          requestId: generateSecret(),
          updatedOn: firestore.Timestamp.fromDate(new Date()),
        });

        // check position

        // check end date

        // generate wom
        const providerDoc: FirebaseFirestore.DocumentData =
          await providerDocRef(providerId).get();

        const apiKey = providerDoc.data().apiKey;
        const aim = providerDoc.data().aim;
        const wom = await generateWom(apiKey, 1, aim);
        response.status(200).send({
          link: wom.link,
          pin: wom.pin,
        });
      });
    }
  );
