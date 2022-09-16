import 'package:countmein/domain/entities/user_card.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants.dart';
import 'date_time_converter.dart';

part 'user_qr_code.freezed.dart';

part 'user_qr_code.g.dart';

@freezed
class UserQrCode with _$UserQrCode {
  const factory UserQrCode({
    required String id,
    required String name,
    required String surname,
    required String cf,
    required String activityId,
    String? email,
  }) = _UserQrCode;

  factory UserQrCode.fromJson(Map<String, Object?> json) =>
      _$UserQrCodeFromJson(json);

  factory UserQrCode.fromOldQrCode(String code) {
    if (code.startsWith(qrCodePrefix) && code.endsWith(qrCodePrefix)) {
      final split = code.split('%');

      print(split);
      print(split.length);
      final userId = split[1];
      final name = split[2];
      final surname = split[3];
      final cf = split[4];
      final activityId = split[5];

      return UserQrCode(
        name: name,
        surname: surname,
        cf: cf,
        id: userId,
        activityId: activityId,
      );
    } else {
      final uri = Uri.parse(code);
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
          // params.containsKey('email') &&
          params.containsKey('pId')) {
        return UserQrCode(
          id: userId,
          name: params['name'] as String,
          surname: params['surname'] as String,
          cf: params['cf'] as String,
          // email: params['email'] as String,
          activityId: params['pId'] as String,
        );
      } else {
        throw Exception();
      }
    }
  }
}

extension UserQrCodeX on UserQrCode {
  toUserCard() {
    return UserCard(id: id,
        name: name,
        surname: surname,
        cf: cf,
        email: email);
  }
}
