import * as functions from "firebase-functions";

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
  attachment: any
) {
  const data = {
    from: "Count Me In NoReply <no-reply@digit.srl>",
    to: to,
    subject: subject,
    template: template,
    "h:X-Mailgun-Variables": json,
    attachment: attachment,
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
  secret: string
) {
  const emails = [email];

  const url = "https://cmi.digit.srl/verification/" + userId + "/" + secret;

  const json = JSON.stringify({
    fullName: fullName,
    verificationUrl: url,
  });

  return sendEmail(emails, "Verifica email", "email_verification", json, []);
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
    attachment
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
    url: url,
  });

  return sendEmail(emails, "Reset password", "reset_password", json, []);
}

// "fullName": "test_fullName",
// "verificationUrl": "test_verificationUrl"
export function sendWomEmail(
  link: string,
  womCount: number,
  email: string,
  pin: string
) {
  const emails = [email];

  const json = JSON.stringify({
    link: link,
    womCount: womCount,
    pin: pin,
  });

  return sendEmail(emails, "Ecco i tuoi wom", "wom_template", json, []);
}
