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
    String? groupId,
    String? groupName,
    int? groupCount,
    int? averageAge,
    double? womanPercentage,
    double? manPercentage,
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

        /*const url =
    "https://cmi.digit.srl/profile/" +
    userId +
    "?" +
    "name=" +
    name +
    "&surname=" +
    surname +
    "&cf=" +
    cf +
    "&pId=" +
    providerId +
    "&gN =" +
    groupName +
    "&gC =" +
    groupCount +
    "&aA =" +
    averageAge +
    "&wP =" +
    womanPercentage +
    "&mP =" +
    manPercentage;*/

        if (params.containsKey('name') &&
            params.containsKey('surname') &&
            params.containsKey('cf') &&
            params.containsKey('pId') &&
            params.containsKey('gId') &&
            params.containsKey('gC') &&
            params.containsKey('gN')) {
          return QrCodeData(
            id: userId,
            name: params['name'] as String,
            surname: params['surname'] as String,
            cf: params['cf'] as String,
            providerId: params['pId'] as String,
            privateId: params['upid'],
            groupName: params['gN'],
            groupId: params['gId'],
            groupCount: int.parse(params['gC'] ?? ''),
            averageAge: int.tryParse(params['aA'] ??''),
            womanPercentage: double.tryParse(params['wP'] ??''),
            manPercentage: double.tryParse(params['mP'] ??''),
          );
        } else if (params.containsKey('name') &&
            params.containsKey('surname') &&
            params.containsKey('cf') &&
            params.containsKey('pId')) {
          return QrCodeData(
            id: userId,
            name: params['name'] as String,
            surname: params['surname'] as String,
            cf: params['cf'] as String,
            providerId: params['pId'] as String,
            privateId: params['upid'],
          );
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
  bool get isGroupCard => groupId != null;
}
