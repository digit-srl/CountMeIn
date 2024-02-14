import 'package:countmein/constants.dart';

String getTotemScreenURL(String providerId, String totemId) {
  return 'https://cmi.digit.srl//embedded/$providerId/$totemId';
}

String getTotemQRCode(String providerId, String totemId, String? requestId) {
  return '$totemBaseUrl/$providerId/$totemId${requestId != null ? '/$requestId' : ''}';
}
