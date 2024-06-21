import { onRequest } from "firebase-functions/v2/https";
import * as dotenv from "dotenv";
dotenv.config();
import {
  providersCollectionRef,
  eventCollectionRef,
} from "./firestore_references";

export const getEventsSecondGen = onRequest(
  { cors: true },
  async (request, response) => {
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
    response.status(200).send(stuff);
  }
);
