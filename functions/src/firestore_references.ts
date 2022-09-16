const admin = require("firebase-admin");
const db = admin.firestore();

export function providersCollectionRef(): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return db.collection("providers");
}

export function providerDocRef(
  providerId: string
): FirebaseFirestore.DocumentReference {
  return providersCollectionRef().doc(providerId);
}

export function privateUsersCollectionRef(
  providerId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return providerDocRef(providerId).collection("usersPrivateData");
}

export function usersCollectionRef(
  providerId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return providerDocRef(providerId).collection("users");
}

export function userDocRef(
  providerId: string,
  userId: string
): FirebaseFirestore.DocumentReference {
  return usersCollectionRef(providerId).doc(userId);
}

export function privateUserDocRef(
  providerId: string,
  userId: string
): FirebaseFirestore.DocumentReference {
  return privateUsersCollectionRef(providerId).doc(userId);
}

export function eventCollectionRef(
  providerId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return db.collection("providers").doc(providerId).collection("events");
}

export function eventDocRef(
  providerId: string,
  eventId: string
): FirebaseFirestore.DocumentReference {
  return eventCollectionRef(providerId).doc(eventId);
}

export function userAccessCollectionRef(
  providerId: string,
  userId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return userDocRef(providerId, userId).collection("accesses");
}