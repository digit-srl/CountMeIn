import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils.dart';

part 'qcode_data.freezed.dart';

@freezed
class QrCodeData with _$QrCodeData {
  const factory QrCodeData({
    required String providerId,
    required String name,
    required String surname,
    required String cf,
    required String id,
    String? email,
    String? privateId,
  }) = _QrCodeData;

  factory QrCodeData.fromQrCode(String code) {
    final qData = validateCustomQrCode(code);
    if (qData != null) {
      return qData;
    } else {
      final uri = Uri.tryParse(code);
      if (uri != null) {
        final params = uri.queryParameters;

        if (uri.host != 'cmi.digit.srl') {
          throw Exception();
        }

        print(uri.pathSegments);
        if (uri.pathSegments.length != 2 || uri.pathSegments[0] != 'profile') {
          throw Exception();
        }

        final userId = uri.pathSegments[1];
        if (params.containsKey('name') &&
            params.containsKey('surname') &&
            params.containsKey('cf') &&
            params.containsKey('pId')
        ) {
          // final n = params['participant'] as int;
          // final etamedia = params['participant'] as int;
          // final manPercentage = params['participant'] as int;
          // final womanPercentage = params['participant'] as int;
          return QrCodeData(
              id: userId,
              name: params['name'] as String,
              surname: params['surname'] as String,
              cf: params['cf'] as String,
              // email: params['email'] as String,
              providerId: params['pId'] as String,
              privateId: params['upid']);
        } else {
          throw const FormatException('Missing params in url');
        }
      }
      throw Exception('not valid qrcode');
    }
  }
}

extension QrCodeDataX on QrCodeData {
  bool get isExternalOrganization => email != null;
}
