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

export function providerPendingInviteDocRef(
  providerId: string,
  inviteId: string
): FirebaseFirestore.DocumentReference {
  return providersCollectionRef()
    .doc(providerId)
    .collection("pendingInvite")
    .doc(inviteId);
}

export function privateUsersCollectionRef(): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return db.collection("usersPrivateData");
}

export function usersCollectionRef(
  providerId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return providerDocRef(providerId).collection("users");
}

export function userGroupCollectionRef(
  providerId: string,
  userId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return providerDocRef(providerId)
    .collection("users")
    .doc(userId)
    .collection("groups");
}

export function userDocRef(
  providerId: string,
  userId: string
): FirebaseFirestore.DocumentReference {
  return usersCollectionRef(providerId).doc(userId);
}

export function privateUserDocRef(
  userId: string
): FirebaseFirestore.DocumentReference {
  return privateUsersCollectionRef().doc(userId);
}

export function eventCollectionRef(
  providerId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return db.collection("providers").doc(providerId).collection("events");
}

export function credentialsCollectionRef(): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return db.collection("credentials");
}

export function managerDocRef(
  managerId: string
): FirebaseFirestore.DocumentReference {
  return credentialsCollectionRef().doc(managerId);
}

export function eventDocRef(
  providerId: string,
  eventId: string
): FirebaseFirestore.DocumentReference {
  return eventCollectionRef(providerId).doc(eventId);
}

export function totemCollectionRef(
  providerId: string,
  eventId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return eventDocRef(providerId, eventId).collection("totems");
}

export function totemDocRef(
  providerId: string,
  eventId: string,
  totemId: string
): FirebaseFirestore.DocumentReference {
  return totemCollectionRef(providerId, eventId).doc(totemId);
}

export function providerTotemCollectionRef(
  providerId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return providerDocRef(providerId).collection("totems");
}

export function providerTotemDocRef(
  providerId: string,
  totemId: string
): FirebaseFirestore.DocumentReference {
  return providerDocRef(providerId).collection("totems").doc(totemId);
}

export function sessionDocRef(
  providerId: string,
  eventId: string,
  sessionId: string
): FirebaseFirestore.DocumentReference {
  return eventCollectionRef(providerId)
    .doc(eventId)
    .collection("sessions")
    .doc(sessionId);
}

export function sessionPrivateUsersCollection(
  providerId: string,
  eventId: string,
  sessionId: string
): FirebaseFirestore.CollectionReference {
  return sessionDocRef(providerId, eventId, sessionId).collection(
    "privateUsers"
  );
}

export function sessionPrivateUsersDoc(
  providerId: string,
  eventId: string,
  sessionId: string,
  privateId: string
): FirebaseFirestore.DocumentReference {
  return sessionPrivateUsersCollection(providerId, eventId, sessionId).doc(
    privateId
  );
}

export function eventPrivateUsersCollection(
  providerId: string,
  eventId: string
): FirebaseFirestore.CollectionReference {
  return eventDocRef(providerId, eventId).collection("privateUsers");
}

export function eventPrivateUsersDoc(
  providerId: string,
  eventId: string,
  privateId: string
): FirebaseFirestore.DocumentReference {
  return eventPrivateUsersCollection(providerId, eventId).doc(privateId);
}

export function userAccessCollectionRef(
  providerId: string,
  userId: string
): FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData> {
  return userDocRef(providerId, userId).collection("accesses");
}
