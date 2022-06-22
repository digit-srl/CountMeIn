import 'package:countmein/domain/entities/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants.dart';
import 'date_time_converter.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String surname,
    required String cf,
    @MyDateTimeConverter() DateTime? addedOn,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

extension UserX on User {
  String qrCode(String sessionId) =>
      '$qrCodePrefix%$id%$name%$surname%$cf%$sessionId%$qrCodePrefix';

  String get fullName => '$name $surname';

  List toCsvList() {
    return [
      name,
      surname,
      cf,
    ];
  }
}
