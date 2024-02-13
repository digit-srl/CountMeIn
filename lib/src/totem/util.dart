import 'package:countmein/constants.dart';

String getTotemScreenURL(String providerId, String totemId) {
  return 'https://cmi.digit.srl//embedded2/$providerId/$totemId';
}

String getTotemQRCode(String providerId, String totemId) {
  return '$totemBaseUrl/$providerId/$totemId';
}
