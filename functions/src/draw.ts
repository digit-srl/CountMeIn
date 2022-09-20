import * as Canvas from "canvas";
import * as QRCode from "qrcode";
import JsBarcode = require("jsbarcode");
import path = require("path");

// add the code below
//module.exports = { drawUserCard, getQrCode, drawGroupCard };

export async function drawUserCard(
  eventTitle: string,
  name: string,
  surname: string,
  cf: string,
  email: string,
  url: string,
  privateId: string,
  providerId: string
): Promise<Buffer> {
  const height = 800;
  const width = height * 1.6;
  const canvas = Canvas.createCanvas(width, height);
  const ctx = canvas.getContext("2d");

  ctx.fillStyle = "white";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  const qrCodeSize = height / 2;
  const qrCodeX = height / 8;
  const qrCodeY = (height - qrCodeSize) / 2;
  const qrCodecanvas = Canvas.createCanvas(qrCodeSize, qrCodeSize);
  const qrCode = await QRCode.toCanvas(qrCodecanvas, url || "", { margin: 0 });
  ctx.drawImage(qrCode, qrCodeX, qrCodeY, qrCodeSize, qrCodeSize);

  ctx.fillStyle = "black";
  ctx.font = "60px Impact";
  ctx.fillText(eventTitle, qrCodeX, height / 5);

  ctx.font = "40px Impact";
  const startText = qrCodeX + qrCodeSize + height / 10;

  const paddingY = height / 20;
  ctx.fillText(name, startText, qrCodeY + paddingY * 2);
  ctx.fillText(surname, startText, qrCodeY + paddingY * 5);
  ctx.fillText(cf, startText, qrCodeY + paddingY * 8);

  const emailY = qrCodeY + qrCodeSize + paddingY * 2;
  ctx.font = "20px Impact";
  ctx.fillStyle = "rgba(211,211,211,1.0)";
  ctx.fillText("Nome", startText, qrCodeY + paddingY);
  ctx.fillText("Cognome", startText, qrCodeY + paddingY * 4);
  ctx.fillText("C.F.", startText, qrCodeY + paddingY * 7);
  ctx.fillText(email, qrCodeX, emailY);

  // Draw wom logo
  const img = await Canvas.loadImage(
    path.join(__dirname, "images", "wom-logo.svg")
  );
  const ratio = img.width / img.height;
  const imgHeight = height / 5;
  const imgWidth = imgHeight * ratio;
  const padding = 40;
  ctx.drawImage(img, width - imgWidth - padding, padding, imgWidth, imgHeight);

  const barcodeWidth = 350;
  const barcodeHeight = 120;
  const barcodeCanvas = Canvas.createCanvas(barcodeWidth, barcodeHeight);
  const content = privateId + ";" + providerId;
  JsBarcode(barcodeCanvas, content);
  ctx.drawImage(
    barcodeCanvas,
    width - barcodeWidth - padding,
    emailY - barcodeHeight / 2,
    barcodeWidth,
    barcodeHeight
  );

  /*
  canvas
      .createPNGStream()
      .pipe(fs.createWriteStream(path.join(__dirname, "image-src-svg.png")));
*/
  return canvas.toBuffer("image/png");
}

export async function drawGroupCard(
  eventTitle: string,
  name: string,
  surname: string,
  cf: string,
  email: string,
  url: string,
  groupName: string,
  groupCount: string,
  averageAge: string,
  manCount: string,
  womanCount: string
): Promise<Buffer> {
  const height = 800;
  const width = height * 1.6;
  const canvas = Canvas.createCanvas(width, height);
  const ctx = canvas.getContext("2d");

  ctx.fillStyle = "white";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  const qrCodeSize = height / 2;
  const qrCodeX = height / 8;
  const qrCodeY = (height - qrCodeSize) / 2;
  const qrCodecanvas = Canvas.createCanvas(qrCodeSize, qrCodeSize);
  const qrCode = await QRCode.toCanvas(qrCodecanvas, url || "", { margin: 0 });
  ctx.drawImage(qrCode, qrCodeX, qrCodeY, qrCodeSize, qrCodeSize);

  ctx.fillStyle = "black";
  ctx.font = "60px Impact";
  ctx.fillText(eventTitle, qrCodeX, height / 5);

  ctx.font = "40px Impact";
  const startText = qrCodeX + qrCodeSize + height / 10;

  const paddingY = height / 22;
  ctx.fillText(name + " " + surname, startText, qrCodeY + paddingY * 2);
  ctx.fillText(groupName, startText, qrCodeY + paddingY * 5);
  ctx.fillText(cf, startText, qrCodeY + paddingY * 8);
  ctx.fillText("N: " + groupCount, startText, qrCodeY + paddingY * 11);
  ctx.fillText("A: " + averageAge, startText + 120, qrCodeY + paddingY * 11);
  ctx.fillText(
    "M: " + manCount + "%",
    startText + 240,
    qrCodeY + paddingY * 11
  );
  ctx.fillText(
    "F: " + womanCount + "%",
    startText + 420,
    qrCodeY + paddingY * 11
  );

  const emailY = qrCodeY + qrCodeSize + paddingY * 2;
  ctx.font = "20px Impact";
  ctx.fillStyle = "rgba(211,211,211,1.0)";
  ctx.fillText("Accompagnatore", startText, qrCodeY + paddingY);
  ctx.fillText("Gruppo", startText, qrCodeY + paddingY * 4);
  ctx.fillText("C.F.", startText, qrCodeY + paddingY * 7);
  ctx.fillText("Info gruppo", startText, qrCodeY + paddingY * 10);
  ctx.fillText(email, qrCodeX, emailY);

  // Draw wom logo
  const img = await Canvas.loadImage(
    path.join(__dirname, "images", "wom-logo.svg")
  );
  const ratio = img.width / img.height;
  const imgHeight = height / 5;
  const imgWidth = imgHeight * ratio;
  const padding = 40;
  ctx.drawImage(img, width - imgWidth - padding, padding, imgWidth, imgHeight);

  return canvas.toBuffer("image/png");
}

export async function getQrCode(value: string) {
  const height = 600;
  const width = height;
  const canvas = Canvas.createCanvas(width, height);
  const ctx = canvas.getContext("2d");
  ctx.fillStyle = "white";
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  ctx.fillStyle = "black";
  const qrCode = await QRCode.toCanvas(canvas, value || "", { margin: 1 });
  ctx.drawImage(qrCode, height, width);
  return canvas.toBuffer("image/png");
}

export async function getBarcode(value: string) {
  const height = 150;
  const width = 450;
  const canvas = Canvas.createCanvas(width, height);
  const ctx = canvas.getContext("2d");
  ctx.fillStyle = "white";
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  ctx.fillStyle = "black";
  const barcode = JsBarcode(canvas, value);
  ctx.drawImage(barcode, height, width);
  return canvas.toBuffer("image/png");
}
