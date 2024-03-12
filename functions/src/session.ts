const { onDocumentDeleted } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");
const db = admin.firestore();
import {
  providerTotemCollectionRef,
  providerTotemDocRef,
} from "./firestore_references";

export const onSessionDeleted = onDocumentDeleted(
  "providers/{providerId}/events/{eventId}/sessions/{sessionId}",
  async (event: any) => {
    try {
      const eventId = event.params.eventId;
      const sessionId = event.params.sessionId;
      const providerId = event.params.providerId;

      console.log(
        "start onSessionDeleted: providerId: " +
          providerId +
          " eventId: " +
          eventId +
          " sessionId: " +
          sessionId
      );

      const totems = await providerTotemCollectionRef(providerId)
        .where("dedicated", "==", false)
        .where("eventId", "==", eventId)
        .where("sessionId", "==", sessionId)
        .get();

      const batch = db.batch();
      for (let index = 0; index < totems.docs.length; index++) {
        const totem = totems.docs[index].data();
        batch.update(providerTotemDocRef(providerId, totem.id), {
          eventId: null,
          eventName: null,
          sessionId: null,
          sessionName: null,
        });
      }
      return batch.commit();
    } catch (ex) {
      console.log("onSessionDeleted failed");
      console.log(ex);
      return null;
    }
  }
);
