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
    from: "CountMeIn <no-reply@digit.srl>",
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
  secret: string
) {
  const emails = [email];

  const url = "https://cmi.digit.srl/verification/" + userId + "/" + secret;

  const json = JSON.stringify({
    fullName: fullName,
    verificationUrl: url,
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
  adminFullname: string
) {
  const emails = ["info@digit.srl", "difrancescogianmarco@gmail.com"];

  const json = JSON.stringify({
    adminFullname: adminFullname,
    provider: providerName,
    adminEmail: adminEmail,
  });

  console.log(json);
  return sendEmail(
    emails,
    "Nuovo Provider in attesa di verifica",
    "new_provider",
    json,
    null,
    null
  );
}

export async function sendWelcomeNewProvider(
  providerName: string,
  adminEmail: string,
  adminFullname: string
) {
  const emails = [adminEmail];

  const json = JSON.stringify({
    adminFullname: adminFullname,
    provider: providerName,
    adminEmail: adminEmail,
  });

  console.log(json);
  return sendEmail(
    emails,
    "Nuovo Provider in attesa di verifica",
    "welcome_new_provider",
    json,
    null,
    null
  );
}
