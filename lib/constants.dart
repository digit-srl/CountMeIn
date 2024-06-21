import 'package:countmein/env.dart';
import 'package:flutter/foundation.dart';

const qrCodePrefix = 'cmi';
const functionBaseUrl = kDebugMode && Environment.isEmulator
    ? 'http://localhost:5003/count-me-in-ef93b/europe-west3'
    : 'https://europe-west3-count-me-in-ef93b.cloudfunctions.net';
const authority = kDebugMode && Environment.isEmulator ? 'localhost:5003' : 'cmi.digit.srl';
const womDomain = kDebugMode && Environment.isEmulator ? 'dev.wom.social': 'wom.social';
const baseUrl = 'https://$authority';

const countMeInProviderId = Environment.isEmulator ? 'Yy31B32YBDJDUt7TbZEl' : 'countmein';

const createUserUrl = '$functionBaseUrl/userSignUp-createUserSecondGen';
const verifyOtpCodeUrl = '$functionBaseUrl/userProfile-verifyOtpCodeSecondGen';
const recoverUserUrl = '$functionBaseUrl/userProfile-recoverUserSecondGen';
const groupCardUrl = '$functionBaseUrl/userSignUp-requestGroupCardSecondGen';
const recoverUserCardUrl = '$functionBaseUrl/userSignUp-recoverUserCardSecondGen';
const requestOtpCodeUrl = '$functionBaseUrl/userProfile-requestOtpCodeSecondGen';
const verifyEmailUrl = '$functionBaseUrl/userSignUp-verifyEmailSecondGen';
const sendResetPasswordUrl = '$functionBaseUrl/userSignUp-sendResetPasswordEmailSecondGen';
const confirmPendingInviteUrl = '$functionBaseUrl/managers-confirmPendingInviteSecondGen';
const changePasswordUrl = '$functionBaseUrl/userSignUp-changePasswordSecondGen';

const totemBaseUrl = 'https://link.wom.social/cmi';