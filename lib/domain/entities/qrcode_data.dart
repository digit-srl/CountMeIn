import 'package:countmein/my_logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:countmein/utils.dart';

part 'qrcode_data.freezed.dart';

@freezed
class QrCodeData with _$QrCodeData {
  const factory QrCodeData({
    required String providerId,
    required String userId,
    required bool isAnonymous,
    String? name,
    String? surname,
    String? cf,
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
    final privateQrCodeData = decodePrivateQrCode(code);
    if (privateQrCodeData != null) {
      return privateQrCodeData;
    }
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

        if (uri.pathSegments.length != 2 || uri.pathSegments[0] != 'profile') {
          throw Exception();
        }
        logger.i('pathSegments: ${uri.pathSegments[0]} ${uri.pathSegments[1]}');

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
          logger.i('this qrcode is a group card');
          return QrCodeData(
            userId: userId,
            name: params['name'] as String,
            surname: params['surname'] as String,
            cf: params['cf'] as String,
            providerId: params['pId'] as String,
            privateId: params['upid'],
            groupName: params['gN'],
            groupId: params['gId'],
            groupCount: int.parse(params['gC'] ?? ''),
            averageAge: int.tryParse(params['aA'] ?? ''),
            womanPercentage: double.tryParse(params['wP'] ?? ''),
            manPercentage: double.tryParse(params['mP'] ?? ''),
            isAnonymous: false,
          );
        } else if (params.containsKey('name') &&
            params.containsKey('surname') &&
            params.containsKey('cf') &&
            params.containsKey('pId')) {
          logger.i('this qrcode is a simple card');
          return QrCodeData(
            userId: userId,
            name: params['name'] as String,
            surname: params['surname'] as String,
            cf: params['cf'] as String,
            providerId: params['pId'] as String,
            privateId: params['upid'],
            isAnonymous: false,
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

@freezed
class PrivateQrCodeData with _$PrivateQrCodeData {
  const factory PrivateQrCodeData({
    required String providerId,
    required String userId,
    required String privateUserId,
  }) = _PrivateQrCodeData;
}
