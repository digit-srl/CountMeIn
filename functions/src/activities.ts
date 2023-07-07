import * as functions from "firebase-functions";
const admin = require("firebase-admin");
import Email = require("./email");
//const bodyParser = require("body-parser");
import * as dotenv from "dotenv";
dotenv.config();
import { createNewAdminForProvider, generateSecret } from "./utils";
//import { FirebaseError } from "@firebase/util";
import { UserRecord } from "firebase-functions/v1/auth";
import { providerDocRef } from "./firestore_references";

export const onActivityRequested = functions
  .region("europe-west3")
  .firestore.document("providerRequests/{docId}")
  .onCreate(async (snap, context) => {
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

    const link = "https://cmi.digit.srl/adminPendingProviders";

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
  });

export const onActivityRequestedUpdated = functions
  .region("europe-west3")
  .firestore.document("providerRequests/{docId}")
  .onUpdate(async (change, context) => {
    // Get an object representing the document
    // e.g. {'name': 'Marie', 'age': 66}
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
            false,
            password
          );
        }
        // }
      }

      if (user === undefined || user === null) {
        throw new functions.https.HttpsError(
          "aborted",
          "user not exist or creation failed"
        );
      }
      const requestId = context.params.docId;

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
  });
