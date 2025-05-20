import { HttpsError } from "firebase-functions/v2/https";
const draw = require("./draw");
import formData = require("form-data");
import Mailgun from "mailgun.js";
import { sendEmailWithBrevo } from "./email_service";
const mailgun = new Mailgun(formData);

const k = process.env.MG_API_KEY ?? "adsfghjkl";

const mg = mailgun.client({
  username: "api",
  key: k,
  public_key: process.env.MG_PUB_KEY,
  url: "https://api.eu.mailgun.net",
});

// add the code below
//module.exports = { sendVerificationEmail, sendUserCardEmail };

export function sendEmail(
  to: Array<string>,
  subject: string,
  template: string,
  json: string,
  attachment: any,
  inline: any
) {
  const data = {
    from: "Count Me In <no-reply@digit.srl>",
    to: to,
    subject: subject,
    template: template,
    "h:X-Mailgun-Variables": json,
    attachment: attachment,
    inline: inline,
    // "recipient-variables": recipient,
  };

  console.log(data);

  return mg.messages
    .create(process.env.MG_DOMAIN ?? "", data)
    .then((msg: any) => {
      console.log("email inviata " + msg);
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

// "fullName": "test_fullName",
// "verificationUrl": "test_verificationUrl"
export function sendVerificationEmail(
  fullName: string,
  email: string,
  userId: string,
  secret: string,
  providerId: string
) {
  const url =
    "https://cmi.digit.srl/verification/" +
    userId +
    "/" +
    secret +
    "/" +
    providerId;
  const data = {
    to: email,
    subject: "Verifica email",
    toName: fullName,
    params: { fullName: fullName, verificationUrl: encodeURI(url) },
    templateId: 76,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

export function sendUserCardEmail(
  fullName: string,
  email: string,
  cf: string,
  buffer: any,
  providerName: string
) {
  const filename = "tesserino.png";

  const data = {
    to: email,
    subject: "Il tuo tesserino",
    toName: fullName,
    params: { fullName: fullName, provider: providerName, cf: cf },
    attachmentName: filename,
    attachmentContent: buffer,
    templateId: 77,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

// "fullName": "test_fullName",
// "verificationUrl": "test_verificationUrl"
export function sendResetPasswordEmail(
  fullName: string,
  email: string,
  userId: string,
  oobCode: string
) {
  const url =
    "https://cmi.digit.srl/reset?n=" +
    fullName +
    "&oobCode=" +
    oobCode +
    "&uid=" +
    userId;

  const data = {
    to: email,
    subject: "Reset password",
    toName: fullName,
    params: { fullName: fullName, url: encodeURI(url) },
    templateId: 69,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });

  //return sendEmail(emails, "Reset password", "reset_password", json, [], null);
}

// "fullName": "test_fullName",
// "verificationUrl": "test_verificationUrl"
export function sendResetPasswordEmailForNotSignedUser(
  fullName: string,
  email: string,
  userId: string,
  oobCode: string
) {
  const url =
    "https://cmi.digit.srl/reset?n=" +
    fullName +
    "&oobCode=" +
    oobCode +
    "&uid=" +
    userId;

  const data = {
    to: email,
    subject: "Reset password",
    toName: fullName,
    params: { fullName: fullName, url: encodeURI(url) },
    templateId: 69,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

// "fullName": "test_fullName",
// "verificationUrl": "test_verificationUrl"
export async function sendWomEmail(
  link: string,
  womCount: number,
  email: string,
  pin: string,
  userName: string,
  providerName: string,
  eventName: string
) {
  if (link === undefined || link === null) {
    throw Error("link is " + link);
  }

  if (pin === undefined || pin === null) {
    throw Error("pin is " + pin);
  }

  const filename = "wom.png";
  const buffer = await draw.getQrCode(link);

  const data = {
    to: email,
    subject: "Ecco i tuoi wom",
    toName: userName,
    params: {
      link: link,
      womCount: womCount,
      pin: pin,
      provider: providerName,
      event: eventName,
      user: userName,
    },
    attachmentName: filename,
    attachmentContent: buffer,
    templateId: 78,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

export async function sendNewActivityRequested(
  providerName: string,
  adminEmail: string,
  adminFullName: string,
  link: string
) {
  const data = {
    to: "info@digit.srl",
    subject: "Nuovo Provider in attesa di verifica",
    toName: adminFullName,
    params: {
      adminFullName: adminFullName,
      provider: providerName,
      adminEmail: adminEmail,
      link: encodeURI(link),
    },
    templateId: 70,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

export async function sendNewActivityRequestedToUser(
  providerName: string,
  adminEmail: string,
  adminFullName: string
) {
  const data = {
    to: adminEmail,
    subject: "La tua richiesta è in attesa di verifica",
    toName: adminFullName,
    params: {
      adminFullName: adminFullName,
      provider: providerName,
      adminEmail: adminEmail,
    },
    templateId: 72,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

export async function sendWelcomeNewProvider(
  providerName: string,
  adminEmail: string,
  adminFullName: string,
  role: string,
  temporaryPassword: string | undefined
) {
  const data = {
    to: adminEmail,
    subject: "Ora sei parte di " + providerName,
    toName: adminFullName,
    params: {
      adminFullName: adminFullName,
      provider: providerName,
      adminEmail: adminEmail,
      role: role,
      temporaryPassword: temporaryPassword,
    },
    templateId: 71,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

export async function sendInvite(
  providerName: string,
  adminFullname: string,
  email: string,
  role: string,
  link: string
) {
  const json = JSON.stringify({
    adminFullname: adminFullname,
    provider: providerName,
    email: email,
    role: role,
    link: encodeURI(link),
  });

  console.log(json);

  const data = {
    to: email,
    subject: "Invito gestione " + providerName,
    toName: adminFullname,
    params: {
      adminFullname: adminFullname,
      provider: providerName,
      email: email,
      role: role,
      link: encodeURI(link),
    },
    templateId: 73,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

export async function sentUserProfileOtpCode(
  fullName: string,
  otpCode: string,
  email: string
) {
  const data = {
    to: email,
    subject: "OTP code",
    toName: fullName,
    params: {
      fullName: fullName,
      otpCode: otpCode,
      email: email,
    },
    templateId: 75,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}

// "fullName"
// "qrCodeUrl"
// "cf"
export function sendGroupCardEmail(
  fullName: string,
  email: string,
  cf: string,
  buffer: any,
  providerName: string,
  groupName: string
) {
  const filename = "tesserino.png";

  const data = {
    to: email,
    subject: "Il tuo tesserino di gruppo",
    toName: fullName,
    params: {
      fullName: fullName,
      cf: cf,
      provider: providerName,
      groupName: groupName,
    },
    attachmentName: filename,
    attachmentContent: buffer,
    templateId: 74,
  };

  return sendEmailWithBrevo(data)
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new HttpsError("aborted", err);
    });
}
