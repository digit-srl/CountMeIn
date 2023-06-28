import * as firestore from "@google-cloud/firestore";

export function dateToFirestoreTimestamp(date: Date) {
  return firestore.Timestamp.fromDate(date);
}

export function firestoreTimestampToDate(timestamp: firestore.Timestamp) {
  return timestamp.toDate();
}
