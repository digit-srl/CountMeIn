import 'package:countmein/main.dart';
import 'package:flutter/foundation.dart';

const flavor = String.fromEnvironment('DEFINE_FLAVOR') == 'collab'
    ? AppFlavor.collab
    : AppFlavor.master;

final isMaster = flavor == AppFlavor.master;
const qrCodePrefix = 'cmi';
const functionBaseUrl = kDebugMode
    ? 'http://localhost:5003/count-me-in-ef93b/europe-west3'
    : 'https://europe-west3-count-me-in-ef93b.cloudfunctions.net';
const authority = kDebugMode ? 'localhost:5003' : 'cmi.digit.srl';
const baseUrl = 'https://$authority';
const passepartoutActivityId = 'wom-count-me-in';
const womDomain = kDebugMode ? 'dev.wom.social': 'wom.social';

const createUserUrl = '$functionBaseUrl/createUser';
const verifyOtpCodeUrl = '$functionBaseUrl/userProfile-verifyOtpCode';
const requestOtpCodeUrl = '$functionBaseUrl/userProfile-requestOtpCode';
const verifyEmailUrl = '$functionBaseUrl/verifyEmail';