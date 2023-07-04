import 'package:countmein/env.dart';
import 'package:countmein/main.dart';
import 'package:flutter/foundation.dart';

const qrCodePrefix = 'cmi';
const functionBaseUrl = kDebugMode && Environment.isEmulator
    ? 'http://localhost:5003/count-me-in-ef93b/europe-west3'
    : 'https://europe-west3-count-me-in-ef93b.cloudfunctions.net';
const authority = kDebugMode && Environment.isEmulator ? 'localhost:5003' : 'cmi.digit.srl';
const baseUrl = 'https://$authority';
const passepartoutActivityId = 'wom-count-me-in';
const womDomain = kDebugMode && Environment.isEmulator ? 'dev.wom.social': 'wom.social';

const countMeInProviderId = Environment.isEmulator ? 'Yy31B32YBDJDUt7TbZEl' : 'countmein';

const createUserUrl = '$functionBaseUrl/userSignUp-createUser';
const verifyOtpCodeUrl = '$functionBaseUrl/userProfile-verifyOtpCode';
const recoverUserUrl = '$functionBaseUrl/userProfile-recoverUser';
const groupCardUrl = '$functionBaseUrl/userSignUp-requestGroupCard';
const recoverUserCardUrl = '$functionBaseUrl/userSignUp-recoverUserCard';
const requestOtpCodeUrl = '$functionBaseUrl/userProfile-requestOtpCode';
const verifyEmailUrl = '$functionBaseUrl/userSignUp-verifyEmail';