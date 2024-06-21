import { onRequest } from "firebase-functions/v2/https";
const admin = require("firebase-admin");
import * as dotenv from "dotenv";
dotenv.config();
const db = admin.firestore();
import * as firestore from "@google-cloud/firestore";
import {
  eventDocRef,
  eventPrivateUsersDoc,
  sessionDocRef,
  sessionPrivateUsersDoc,
} from "./firestore_references";

export const scanSecondGen = onRequest(
  { cors: true },
  async (request, response) => {
    console.log(request.body);

    if (request.method !== "POST") {
      response.status(403).send("Forbidden!");
      return;
    }

    const data = request.body;
    const eventId = data.eventId;
    const userId = data.userId;
    const groupId = data.groupId;
    const privateId = data.privateId;
    const hasPrivateInfo = data.hasPrivateInfo ?? privateId != null;
    const userCardProviderId = data.userCardProviderId;
    const eventProviderId = data.providerId;
    const isSingleAccessType = data.isSingleAccessType;
    const scanMode = data.scanMode;
    const isGroup = data.isGroup;
    const groupLeaderId = data.groupLeaderId;
    const isAnonymous = data.isAnonymous;
    const groupName = data.groupName;
    const name = data.name;
    const surname = data.surname;
    const cf = data.cf;
    const fromExternalOrganization = data.fromExternalOrganization;
    const email = data.email;
    const groupCount = data.groupCount;
    const averageAge = data.averageAge;
    const manPercentage = data.manPercentage;
    const womanPercentage = data.womanPercentage;
    const timestamp = new Date(data.timestamp);
    const firestoreTimestamp = firestore.Timestamp.fromDate(timestamp);

    if (eventProviderId == null || userCardProviderId == null) {
      response.status(400).send("invalid providerId or userCardProviderId");
      return;
    }

    if (isAnonymous && privateId == null) {
      response.status(400).send("invalid privateId");
      return;
    }

    if (!isGroup && (userId == null || userId == "")) {
      response.status(400).send("invalid userId");
      return;
    }

    if (isGroup && (groupLeaderId == null || groupId == null)) {
      response.status(400).send("invalid groupLeaderId");
      return;
    }

    const eventRef = eventDocRef(eventProviderId, eventId);
    const eventDoc = await eventRef.get();
    const event = eventDoc.data();

    if (event == null) {
      response.status(400).send("event is null, " + eventRef.path);
      return;
    }

    const id = isGroup ? groupId : userId;
    const userSubEventDocRef = sessionDocRef(
      eventProviderId,
      eventId,
      event.activeSessionId!
    )
      .collection("users")
      .doc(isAnonymous ? privateId : id);
    console.log(userSubEventDocRef.path);
    const userDoc = await userSubEventDocRef.get();
    const userData = userDoc.data();
    const userSubEventExists = userDoc.exists && userData != null;
    console.log(
      isAnonymous
        ? privateId
        : id + " exists in the event collection? :  " + userSubEventExists + " "
    );

    // Check out
    if (!isSingleAccessType && scanMode == "checkOut") {
      // se l utente esiste vuol dire che ha fatto il check in
      if (userSubEventExists) {
        // Se non è stato fatto ancora il check out aggiungo la data di check out
        if (userData.checkOutAt == null) {
          await userSubEventDocRef.update({
            checkOutAt: firestoreTimestamp,
          });
          response.status(200).send({
            type: "check_out",
            status: "check_out_completed",
          });
          return;
        }
      } else {
        response.status(200).send({
          type: "check_out",
          status: "missing_check_in",
        });
        return;
      }
    }

    // Check in
    if (userSubEventExists) {
      console.log(eventProviderId);
      console.log(eventId);
      console.log(id);
      const ref = await eventDocRef(eventProviderId, eventId)
        .collection("users")
        .doc(isAnonymous ? privateId : id);

      await ref.update({
        participationCount: firestore.FieldValue.increment(1),
      });
      response.status(200).send({
        type: "check_in",
        status: "participation_count_incremented",
      });
      return;
    } else {
      // Se è un gruppo controllo che il rappresentante abbia fatto checkin
      if (isGroup) {
        const groupLeaderDoc = await eventDocRef(eventProviderId, eventId)
          .collection("users")
          .doc(groupLeaderId)
          .get();
        if (!groupLeaderDoc.exists) {
          response.status(200).send({
            type: "check_in",
            status: "leader_group_not_exist",
          });
          return;
        }
      }

      const json: Record<string, any> = {
        isGroup: isGroup,
        id: userId,
        name: name,
        surname: surname,
        email: email,
        cf: cf,
        fromExternalOrganization: fromExternalOrganization,
        privateId: privateId,
        groupName: groupName,
        groupCount: groupCount,
        averageAge: averageAge,
        manPercentage: manPercentage,
        womanPercentage: womanPercentage,
        isAnonymous: isAnonymous,
        providerId: userCardProviderId,
        hasPrivateInfo: hasPrivateInfo,
      };

      if (isSingleAccessType && scanMode == "checkOut") {
        //eventUser = eventUser.copyWith(checkOutAt: DateTime.now());
        json["checkOutAt"] = firestoreTimestamp;
      } else if (!isSingleAccessType && scanMode == "checkIn") {
        //eventUser = eventUser.copyWith(checkInAt: DateTime.now());
        json["checkInAt"] = firestoreTimestamp;
      }

      const batch = db.batch();

      // Aggiungo l utente nella lista utenti dell evento
      batch.set(userSubEventDocRef, json);

      if (!isGroup && privateId != null) {
        console.log(
          "Salvo il mio private id nella collezione privateUsers della sessione"
        );
        batch.set(
          sessionPrivateUsersDoc(
            eventProviderId,
            eventId,
            event.activeSessionId!,
            privateId
          ),
          {
            id: privateId,
          }
        );
      }

      const globalUserRef = eventDocRef(eventProviderId, eventId)
        .collection("users")
        .doc(isAnonymous ? privateId : id);
      const globalUserDoc = await globalUserRef.get();
      console.log(
        isAnonymous
          ? privateId
          : id + " esiste nella collezione globale? " + globalUserDoc.exists
      );

      if (!globalUserDoc.exists) {
        console.log("Salvo nuovo utente nella collezione globale");
        batch.set(globalUserRef, {
          isGroup: isGroup,
          id: userId,
          name: name,
          surname: surname,
          email: email,
          cf: cf,
          fromExternalOrganization: fromExternalOrganization,
          groupName: groupName,
          groupCount: groupCount,
          averageAge: averageAge,
          manPercentage: manPercentage,
          womanPercentage: womanPercentage,
          isAnonymous: isAnonymous,
          providerId: userCardProviderId,
          participationCount: 1,
          hasPrivateInfo: hasPrivateInfo,
        });

        if (!isGroup && privateId != null) {
          console.log("Salvo il mio private id nella collezione privateUsers");
          batch.set(eventPrivateUsersDoc(eventProviderId, eventId, privateId), {
            id: privateId,
          });
        }
      }
      await batch.commit();
      response.status(200).send({
        type: "check_in",
        status: "check_in_completed",
      });
      return;
    }
  }
);

/*
export const processQrCode = functions
  .region("europe-west3")
  .https.onRequest(
    async (request: functions.https.Request, response: functions.Response) => {
      console.log(request.body);

      if (request.method !== "POST") {
        response.status(403).send("Forbidden!");
        return;
      }

      const data = request.body;

      const qrCode = data.qrCode;

      const url = new URLWrapper(qrCode);
      // console.log(url.getParam("foo") === "bar");
      // console.log(url.getParam("name") === undefined);
      // console.log(url.getParam("age") === "3");

      console.log(url.getParam("pId"));
      response.send("complete");
    }
  );


export class URLWrapper {
  private readonly _url!: URL;
  private readonly _params!: URLSearchParams;

  constructor(rawURL: string) {
    try {
      this._url = new URL(rawURL);
      this._params = new URLSearchParams(this._url.search);
    } catch (e) {
      console.error("Un-parsable URL", e);
    }
  }

  getParam(name: string): string | undefined {
    if (!this._params) {
      return "";
    }

    const value = this._params.get(name);
    return !value || value === "undefined" || value === "null"
      ? undefined
      : value;
  }
}  
*/
