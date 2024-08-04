// The Cloud Functions for Firebase SDK to set up triggers and logging.
import { onSchedule } from "firebase-functions/v2/scheduler";
import * as firestore from "@google-cloud/firestore";
import { eventDocRef, sessionsCollection } from "./firestore_references";

const admin = require("firebase-admin");
const db = admin.firestore();

// Manually run the task here https://console.cloud.google.com/cloudscheduler
export const dynamicActivationCron = onSchedule(
  "*/15 * * * *",
  async (event) => {
    await dynamicActivation();
  }
);

/*
export const dynamicActivationPOST = onRequest(async (req, respo) => {
  await dynamicActivation();
  respo.send({});
});
*/

async function dynamicActivation() {
  // Fetch all user details.
  const eventsToActivate = await getEventsToActivate();

  console.log("events with dynamic activation: " + eventsToActivate.length);

  eventsToActivate.forEach(
    async (doc: FirebaseFirestore.QueryDocumentSnapshot) => {
      const eventId = doc.id;
      const docRef = doc.ref;

      const providerId = docRef.parent.parent?.id;
      const eventData = doc.data();
      const activeSessionId = eventData.activeSessionId;
      const sessions = await getSessionsToActivate(
        providerId!,
        eventId,
        activeSessionId
      );

      console.log("------------------------");
      console.log("providerId " + providerId);
      console.log("eventId " + eventId);
      console.log("eventName " + eventData.name);
      console.log("sessions availables: " + sessions.docs.length);

      if (sessions.docs.length > 0) {
        const sessionDoc = sessions.docs[0];
        const sessionData = sessionDoc.data();
        if (sessionData.endAt != null) {
          console.log("sessionId: " + sessionDoc.id);
          console.log("sessionName: " + sessionData.name);
          console.log("start: " + sessionData.startAt.toDate());
          console.log("end: " + sessionData.endAt.toDate());
          await eventDocRef(providerId!, eventId).update({
            activeSessionId: sessionDoc.id,
          });
        }
      }
    }
  );
}

async function getEventsToActivate() {
  const querySnapshot = await db
    .collectionGroup("events")
    .where("status", "==", "live")
    .where("dynamicActivation", "==", true)
    .get();

  return querySnapshot.docs;
}

async function getSessionsToActivate(
  providerId: string,
  eventId: string,
  activeSessionId: string
) {
  const now = new Date();
  const firestoreNow = firestore.Timestamp.fromDate(now);

  const sessions = await sessionsCollection(providerId, eventId)
    .where("startAt", "<=", firestoreNow)
    .where("endAt", ">", firestoreNow)
    .where("id", "!=", activeSessionId)
    .orderBy("endAt")
    .limit(1)
    .get();

  return sessions;
}
