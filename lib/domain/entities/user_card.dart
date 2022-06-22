import 'package:countmein/domain/entities/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants.dart';
import 'date_time_converter.dart';

part 'user_card.freezed.dart';

part 'user_card.g.dart';

@freezed
class UserCard with _$UserCard {
  const factory UserCard({
    required String id,
    required String name,
    required String surname,
    required String cf,
    @MyDateTimeConverter() DateTime? addedOn,
  }) = _UserCard;

  factory UserCard.fromJson(Map<String, Object?> json) => _$UserCardFromJson(json);
}

extension UserCardX on UserCard {
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
