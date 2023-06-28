import * as functions from "firebase-functions";
//const admin = require("firebase-admin");
import * as dotenv from "dotenv";
dotenv.config();
//const db = admin.firestore();
//const cors = require("cors")({ origin: true });
//import * as firestore from "@google-cloud/firestore";
import {
  //userDocRef,
  //privateUserDocRef,
  providersCollectionRef,
  eventCollectionRef,
} from "./firestore_references";

export const getEvents = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      if (request.method !== "POST") {
        response.status(403).send("Forbidden!");
        return;
      }
      console.log(request.body);

      const data = request.body;
      const instrumentId = data.instrumentId;

      if (instrumentId == null) {
        response.status(404).send("bad_request");
        return;
      }

      const providerDocs = await providersCollectionRef()
        .where("instrumentId", "==", instrumentId)
        .get();
      var stuff: Array<Object> = [];
      for (let index = 0; index < providerDocs.docs.length; index++) {
        const provider = providerDocs.docs[index];
        const data = provider.data();
        const providerId = data.id;
        console.log("providerId: " + providerId);
        const eventDocs = await eventCollectionRef(providerId)
          .where("status", "==", "live")
          .get();
        eventDocs.forEach((doc) => {
          stuff.push(doc.data());
        });
      }
      /*
      const eventDocs = await eventCollectionRef(providerId)
        .where("status", "==", "live")
        .get();
      console.log(
        "I finded " + eventDocs.size + " events for providerId: " + providerId
      );
      eventDocs.forEach((doc) => {
        stuff.push(doc.data());
      });*/
      response.status(200).send(stuff);
    }
  );
