import * as firestore from "@google-cloud/firestore";
const admin = require("firebase-admin");
import Email = require("./email");
import * as dotenv from "dotenv";
dotenv.config();
const db = admin.firestore();
import { UserRecord } from "firebase-functions/v1/auth";
import { providerDocRef } from "./firestore_references";
const axios = require("axios").default;

export function generateSecret(): string {
  return Math.random().toString(36).slice(-8);
}
export function dateToFirestoreTimestamp(date: Date) {
  return firestore.Timestamp.fromDate(date);
}

export function firestoreTimestampToDate(timestamp: firestore.Timestamp) {
  return timestamp.toDate();
}

export async function createNewAdminForProvider(
  name: string,
  surname: string,
  email: string,
  role: string,
  providerId: string,
  cf: string,
  password: string
): Promise<UserRecord> {
  const fullName = name + " " + surname;
  const user = await admin.auth().createUser({
    email: email,
    emailVerified: true,
    password: password,
    displayName: fullName,
  });
  console.log("user created " + user.uid);

  let map = new Map<string, string>();
  map.set(providerId, role);

  let jsonObject = Object.fromEntries(map);

  //await admin.auth().setCustomUserClaims(user.uid, {
  //  role: role,
  //});
  await db.doc("credentials" + "/" + user.uid).set({
    createdOn: firestore.Timestamp.fromDate(new Date()),
    uid: user.uid,
    surname: surname,
    name: name,
    email: email,
    emailVerified: user.emailVerified,
    providersRole: jsonObject,
    cf: cf,
    temporaryPassword: true,
  });
  //await generateAndSendResetPasswordEmail(fullName, email);
  return user;
}

export async function generateAndSendResetPasswordEmail(
  fullName: string,
  userEmail: string,
  userId: string
) {
  try {
    const link = await admin.auth().generatePasswordResetLink(userEmail);

    console.log(link);

    let paramString = link.split("?")[1];
    let queryString = new URLSearchParams(paramString);

    for (let pair of queryString.entries()) {
      console.log("Key is: " + pair[0]);
      console.log("Value is: " + pair[1]);
    }

    const oobCode = queryString.get("oobCode");
    console.log("oobCode => " + oobCode);
    if (oobCode === undefined || oobCode === null) {
      throw Error();
    }
    await Email.sendResetPasswordEmail(fullName, userEmail, userId, oobCode);
  } catch (ex) {
    throw ex;
  }
}

export function addDays(numOfDays: number, date = new Date()) {
  const dateCopy = new Date(date.getTime());

  dateCopy.setDate(dateCopy.getDate() + numOfDays);

  return dateCopy;
}

export function dateToUTC(date: Date) {
  const utcDate = new Date(date.toUTCString().slice(0, -4));
  return utcDate;
}

export async function getProviderData(
  providerId: string
): Promise<firestore.DocumentData> {
  const providerDoc = await providerDocRef(providerId).get();
  const providerData = providerDoc.data();
  if (!providerDoc.exists || providerData == null) {
    console.log("User not found");
    throw Error();
  }
  return providerData;
}

export function twoDecimalPlaces(num: number): string {
  return (Math.round(num * 100) / 100).toFixed(2);
}

export async function generateWom(
  apiKey: string,
  wom: number,
  aim: string,
  lat: number,
  long: number
) {
  const data = {
    apiKey: apiKey,
    womCount: wom,
    lat: lat,
    long: long,
    aim: aim,
  };
  console.log(data);

  const headers = {
    "X-SuperSecret-Key": process.env.SECRET_HEADER_KEY,
  };

  const response = await axios.post(
    process.env.WOM_SERVICE_DOMAIN + "/vouchers",
    data,
    {
      headers: headers,
    }
  );
  console.log(response.status);
  const link = response.data.womLink;
  const pin = response.data.womPassword;
  return {
    link: link,
    pin: pin,
  };
}
