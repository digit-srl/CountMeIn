import {
  onDocumentCreated,
  onDocumentUpdated,
} from "firebase-functions/v2/firestore";
const admin = require("firebase-admin");
import Email = require("./email");
import * as dotenv from "dotenv";
dotenv.config();
import { createNewAdminForProvider, generateSecret } from "./utils";
import { HttpsError } from "firebase-functions/v2/https";
import { UserRecord } from "firebase-functions/v1/auth";
import { providerDocRef } from "./firestore_references";

export const onActivityRequested = onDocumentCreated(
  "providerRequests/{docId}",
  async (event) => {
    const snap = event.data;

    if (snap == null) {
      console.log("onActivityRequested event data null");
      return;
    }

    const provider: FirebaseFirestore.DocumentData = snap.data();
    const adminFullName = provider.adminName + " " + provider.adminSurname;
    console.log(
      "new provider requested" +
        adminFullName +
        " " +
        provider.name +
        " " +
        provider.adminEmail
    );

    const link = "https://cmi.digit.srl/admin/pending-providers";

    await Email.sendNewActivityRequestedToUser(
      provider.name,
      provider.adminEmail,
      adminFullName
    );
    return Email.sendNewActivityRequested(
      provider.name,
      provider.adminEmail,
      adminFullName,
      link
    );
  }
);

export const onActivityRequestedUpdated = onDocumentUpdated(
  "providerRequests/{docId}",
  async (event) => {
    const requestId = event.params.docId;
    const change = event.data;

    if (change == null) {
      console.log("onActivityRequested event data null");
      return;
    }

    const provider: FirebaseFirestore.DocumentData = change.after.data();
    const previousProvider: FirebaseFirestore.DocumentData =
      change.before.data();

    if (previousProvider.status === "pending" && provider.status === "live") {
      const providerId = provider.id;
      const email = provider.adminEmail;
      const surname = provider.adminSurname;
      const name = provider.adminName;
      const cf = provider.adminCf;
      const fullName = name + " " + surname;

      console.log(
        "new provider created" + name + " " + provider.name + " " + email
      );

      let user: UserRecord | undefined;
      let password: string | undefined;

      try {
        user = await admin.auth().getUserByEmail(email);
        console.log("user exist");
      } catch (err: any) {
        console.log(err);
        console.log(typeof err);
        //if (err instanceof FirebaseError) {
        //console.error(err.code);
        if (err.code === "auth/user-not-found") {
          console.log("User doesn't exist yet, create it...");
          password = generateSecret();
          user = await createNewAdminForProvider(
            name,
            surname,
            email,
            "admin",
            providerId,
            cf,
            password
          );
        }
        // }
      }

      if (user === undefined || user === null) {
        throw new HttpsError("aborted", "user not exist or creation failed");
      }

      let map = {
        id: user.uid,
        role: "admin",
        email: email,
        name: fullName,
      };
      let managers = new Map<string, Object>();
      managers.set("managers." + user.uid, map);
      let jManagers = Object.fromEntries(managers);

      await providerDocRef(requestId).set(provider);
      await providerDocRef(requestId).update(jManagers);
      await Email.sendWelcomeNewProvider(
        provider.name,
        email,
        fullName,
        "admin",
        password
      );
    }
  }
);
