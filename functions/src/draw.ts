import * as Canvas from "canvas";
import * as QRCode from "qrcode";
//import JsBarcode = require("jsbarcode");
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
  userId: string,
  privateId: string,
  providerId: string
): Promise<Buffer> {
  const height = 800;
  const width = height * 1.6;
  const canvas = Canvas.createCanvas(width, height);
  const ctx = canvas.getContext("2d");
  ctx.fillStyle = "white";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  const rowHeight = height / 4;
  //const firstRowY = 0;
  //const middleFirstRowY = rowHeight / 2;
  const secondRowY = rowHeight;
  const middleSecondRowY = secondRowY + rowHeight / 2;
  //const thirdRowY = rowHeight * 2;
  const columnWidth = width / 3;
  const columnPadding = 20;
  const firstColumnX = 0;
  const secondColumnX = columnWidth;
  //const thirdColumnX = secondColumnX + columnWidth;

  const qrCodeSize = columnWidth * 0.7;
  const qrCodeX = firstColumnX + columnWidth * 0.15;
  const qrCodeY = middleSecondRowY;
  //const qrCodeX = height / 8;
  //const qrCodeY = (height - qrCodeSize) / 2;
  const qrCodecanvas = Canvas.createCanvas(qrCodeSize, qrCodeSize);
  const qrCode = await QRCode.toCanvas(qrCodecanvas, url || "", { margin: 0 });
  ctx.drawImage(qrCode, qrCodeX, qrCodeY, qrCodeSize, qrCodeSize);

  // Draw wom logo
  const img = await Canvas.loadImage(
    path.join(__dirname, "images", "wom-logo.svg")
  );
  const ratio = img.width / img.height;
  const imgHeight = height / 5;
  const imgWidth = imgHeight * ratio;
  const padding = 40;
  const logoX = width - imgWidth - padding;

  ctx.drawImage(img, logoX, secondRowY - imgHeight / 2, imgWidth, imgHeight);

  // private qrcode
  const privateQrCodeSize = qrCodeSize / 2;
  //const privateQrCodeX = thirdColumnX + columnWidth * 0.15;
  const privateQrCodeY = qrCodeY + qrCodeSize - privateQrCodeSize;
  const privateContent = "cmi://" + providerId + "/" + userId + "/" + privateId;
  const privateQrCodecanvas = Canvas.createCanvas(
    privateQrCodeSize,
    privateQrCodeSize
  );
  const privateQrCode = await QRCode.toCanvas(
    privateQrCodecanvas,
    privateContent || "",
    { margin: 0 }
  );
  ctx.drawImage(
    privateQrCode,
    logoX + imgWidth / 2 - privateQrCodeSize / 2,
    privateQrCodeY,
    privateQrCodeSize,
    privateQrCodeSize
  );

  const serraturaImg = await Canvas.loadImage(
    path.join(__dirname, "images", "serratura.svg")
  );

  const spyImg = await Canvas.loadImage(
    path.join(__dirname, "images", "lock_2.svg")
  );

  const r = spyImg.width / spyImg.height;
  const spyImgWidth = privateQrCodeSize * 0.8;
  const spyImgHeight = spyImgWidth / r;
  const middleLogoX = logoX + imgWidth / 2 - spyImgWidth / 2;
  //const spyImgWidth = spyImgHeight;
  //const spyImgX = privateQrCodeX + privateQrCodeSize / 2 - spyImgWidth / 2;
  //const spyImgY = qrCodeY + privateQrCodeSize / 2 - spyImgHeight / 2;
  ctx.drawImage(
    spyImg,
    middleLogoX,
    privateQrCodeY - spyImgHeight,
    spyImgWidth,
    spyImgHeight
  );

  const serraturaRatio = serraturaImg.width / serraturaImg.height;
  const serraturaHeight = privateQrCodeSize / 4;
  const serraturaWidth = serraturaHeight * serraturaRatio;

  const centerPrivateQrCodeY =
    privateQrCodeY + privateQrCodeSize / 2 - serraturaHeight / 2 - 4;
  //Draw white box
  ctx.fillStyle = "white";
  ctx.fillRect(
    logoX + imgWidth / 2 - serraturaWidth / 2,
    centerPrivateQrCodeY,
    serraturaHeight,
    serraturaHeight
  );

  // Draw serratura
  ctx.drawImage(
    serraturaImg,
    logoX + imgWidth / 2 - serraturaWidth / 2,
    centerPrivateQrCodeY,
    serraturaWidth,
    serraturaHeight
  );

  ctx.fillStyle = "black";
  ctx.font = "60px Impact";
  ctx.fillText(eventTitle, qrCodeX, secondRowY);

  ctx.font = "26px Impact";
  const startTextX = secondColumnX + columnPadding;
  //const startTextX = q + qrCodeSize + height / 10;

  const paddingY = qrCodeSize / 11;
  ctx.fillText(name, startTextX, qrCodeY + paddingY * 2);
  ctx.fillText(surname, startTextX, qrCodeY + paddingY * 5);
  ctx.fillText(cf, startTextX, qrCodeY + paddingY * 8);

  ctx.font = "18px Impact";
  ctx.fillStyle = "rgba(211,211,211,1.0)";
  ctx.fillText("Nome", startTextX, qrCodeY + paddingY);
  ctx.fillText("Cognome", startTextX, qrCodeY + paddingY * 4);
  ctx.fillText("C.F.", startTextX, qrCodeY + paddingY * 7);
  ctx.fillText("Email", startTextX, qrCodeY + paddingY * 10);

  ctx.fillText(email, startTextX, qrCodeY + paddingY * 11);

  //const emailY = qrCodeY + qrCodeSize + paddingY * 2;
  //ctx.fillText(email, qrCodeX, emailY);

  /*
  // draw image on center of qrcode
  const spyImg = await Canvas.loadImage(
    path.join(__dirname, "images", "user-spy.svg")
  );
  const spyImgHeight = privateQrCodeSize / 4;
  const spyImgWidth = spyImgHeight;

  const spyImgX = privateQrCodeX + privateQrCodeSize / 2 - spyImgWidth / 2;
  const spyImgY = qrCodeY + privateQrCodeSize / 2 - spyImgHeight / 2;
  ctx.fillStyle = "white";
  ctx.fillRect(spyImgX, spyImgY, spyImgWidth, spyImgHeight);
  ctx.drawImage(spyImg, spyImgX, spyImgY, spyImgWidth, spyImgHeight);
  */

  /*

  const barcodeWidth = 350;
  const barcodeHeight = 120;
  const barcodeCanvas = Canvas.createCanvas(barcodeWidth, barcodeHeight);
  JsBarcode(barcodeCanvas, privateContent);
  ctx.drawImage(
    barcodeCanvas,
    padding,
    emailY + 20
    //width - barcodeWidth - padding,
    //emailY - barcodeHeight / 2
    //barcodeWidth,
    //barcodeHeight
  );
*/
  /*
  canvas
      .createPNGStream()
      .pipe(fs.createWriteStream(path.join(__dirname, "image-src-svg.png")));
*/
  return canvas.toBuffer("image/png");
}

function float2int(value: number) {
  return Math.round(value);
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
  averageAge: string | undefined,
  manPercentage: number | undefined,
  womanPercentage: number | undefined
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

  if (averageAge != null) {
    ctx.fillText("A: " + averageAge, startText + 120, qrCodeY + paddingY * 11);
  }

  if (manPercentage != null) {
    ctx.fillText(
      "M: " + float2int(manPercentage * 100).toString() + "%",
      startText + 240,
      qrCodeY + paddingY * 11
    );
  }

  if (womanPercentage != null) {
    ctx.fillText(
      "F: " + float2int(womanPercentage * 100).toString() + "%",
      startText + 420,
      qrCodeY + paddingY * 11
    );
  }

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

/*
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
}*/
