import * as functions from "firebase-functions";
const draw = require("./draw");
import formData = require("form-data");
import Mailgun from "mailgun.js";
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
      throw new functions.https.HttpsError("aborted", err);
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
  //privateId: string
) {
  const emails = [email];

  const url =
    "https://cmi.digit.srl/verification/" +
    userId +
    "/" +
    secret +
    "/" +
    providerId;

  const json = JSON.stringify({
    fullName: fullName,
    verificationUrl: encodeURI(url),
  });

  return sendEmail(
    emails,
    "Verifica email",
    "email_verification",
    json,
    [],
    null
  );
}

// "fullName"
// "qrCodeUrl"
// "cf"
export function sendUserCardEmail(
  fullName: string,
  email: string,
  cf: string,
  buffer: Buffer,
  providerName: string
) {
  const emails = [email];

  const json = JSON.stringify({
    fullName: fullName,
    cf: cf,
    provider: providerName,
  });

  const filename = "tesserino.png";
  const attachment = {
    data: buffer,
    filename: filename,
  };

  return sendEmail(
    emails,
    "Il tuo tesserino",
    "card_template",
    json,
    attachment,
    null
  )
    .then(() => {
      return true;
    }) // logs response data
    .catch((err: any) => {
      console.log(err);
      throw new functions.https.HttpsError("aborted", err);
    });
}

// "fullName": "test_fullName",
// "verificationUrl": "test_verificationUrl"
export function sendResetPasswordEmail(
  fullName: string,
  email: string,
  oobCode: string
) {
  const emails = [email];

  const url =
    "https://cmi.digit.srl/reset?n=" + fullName + "&oobCode=" + oobCode;

  const json = JSON.stringify({
    fullName: fullName,
    url: encodeURI(url),
  });

  return sendEmail(emails, "Reset password", "reset_password", json, [], null);
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
  const emails = [email];

  if (link === undefined || link === null) {
    throw Error("link is " + link);
  }

  if (pin === undefined || pin === null) {
    throw Error("pin is " + pin);
  }

  const filename = "wom.png";
  const buffer = await draw.getQrCode(link);
  const attachment = {
    data: buffer,
    filename: filename,
  };

  const json = JSON.stringify({
    link: link,
    womCount: womCount,
    pin: pin,
    provider: providerName,
    event: eventName,
    user: userName,
  });

  console.log(json);
  return sendEmail(
    emails,
    "Ecco i tuoi wom",
    "wom_template",
    json,
    null,
    attachment
  );
}

export async function sendNewActivityRequested(
  providerName: string,
  adminEmail: string,
  adminFullName: string,
  link: string
) {
  const emails = ["info@digit.srl", "difrancescogianmarco@gmail.com"];

  const json = JSON.stringify({
    adminFullName: adminFullName,
    provider: providerName,
    adminEmail: adminEmail,
    link: encodeURI(link),
  });

  console.log(json);
  return sendEmail(
    emails,
    "Nuovo Provider in attesa di verifica",
    "new_provider_request",
    json,
    null,
    null
  );
}
export async function sendNewActivityRequestedToUser(
  providerName: string,
  adminEmail: string,
  adminFullName: string
) {
  const emails = [adminEmail];

  const json = JSON.stringify({
    adminFullName: adminFullName,
    provider: providerName,
    adminEmail: adminEmail,
  });

  console.log(json);
  return sendEmail(
    emails,
    "La tua richiesta è in attesa di verifica",
    "new_provider_request_to_user",
    json,
    null,
    null
  );
}

export async function sendWelcomeNewProvider(
  providerName: string,
  adminEmail: string,
  adminFullName: string,
  role: string
) {
  const emails = [adminEmail];

  const json = JSON.stringify({
    adminFullName: adminFullName,
    provider: providerName,
    adminEmail: adminEmail,
    role: role,
  });

  console.log(json);
  return sendEmail(
    emails,
    "Ora sei parte di " + providerName,
    "welcome_new_provider",
    json,
    null,
    null
  );
}

export async function sendInvite(
  providerName: string,
  adminFullname: string,
  email: string,
  role: string,
  link: string
) {
  const emails = [email];

  const json = JSON.stringify({
    adminFullname: adminFullname,
    provider: providerName,
    email: email,
    role: role,
    link: encodeURI(link),
  });

  console.log(json);
  return sendEmail(
    emails,
    "Invito gestione " + providerName,
    "invite_to_manage_provider",
    json,
    null,
    null
  );
}

export async function sentUserProfileOtpCode(
  fullName: string,
  otpCode: string,
  email: string
) {
  const emails = [email];

  const json = JSON.stringify({
    fullName: fullName,
    otpCode: otpCode,
    email: email,
  });

  console.log(json);
  return sendEmail(
    emails,
    "Otp code",
    "user_profile_otp_code",
    json,
    null,
    null
  );
}
