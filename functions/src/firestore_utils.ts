import * as firestore from "@google-cloud/firestore";
import { usersCollectionRef, managerDocRef } from "./firestore_references";

export async function getUserData(
  providerId: string,
  userId: string
): Promise<firestore.DocumentData> {
  const userDoc = await usersCollectionRef(providerId).doc(userId).get();
  const userData = userDoc.data();
  if (!userDoc.exists || userData == null) {
    console.log("User not found in ");
    throw Error("User not found");
  }
  return userData;
}

export async function getManagerUserData(
  managerId: string
): Promise<firestore.DocumentData> {
  const managerDoc = await managerDocRef(managerId).get();
  const managerData = managerDoc.data();
  if (!managerDoc.exists || managerData == null) {
    const message = "Manager not found in credentials/" + managerId;
    console.log(message);
    throw Error(message);
  }
  return managerData;
}
