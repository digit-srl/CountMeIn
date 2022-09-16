import 'package:cloud_firestore/cloud_firestore.dart';
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
    String? email,
    String? secret,
    String? gender,
    @MyDateTimeConverter() DateTime? addedOn,
    @Default(false) bool emailVerified,
  }) = _UserCard;

  factory UserCard.fromJson(Map<String, Object?> json) =>
      _$UserCardFromJson(json);

  factory UserCard.fromOldQrCode(String code) {
    final split = code.split('%');

    print(split);
    print(split.length);
    if (split.length != 7) {
      throw Exception();
    }
    final userId = split[1];
    final name = split[2];
    final surname = split[3];
    final cf = split[4];
    final activityId = split[5];

    return UserCard(
      name: name,
      surname: surname,
      cf: cf,
      id: userId,
      addedOn: DateTime.now(),
    );
  }
}

extension UserCardX on UserCard {
  String qrCode(String activityId) =>
      '$qrCodePrefix%$id%$name%$surname%$cf%$activityId%$qrCodePrefix';

  String qrCodeUrl(activityId) {
    final params = <String, String>{};
    //params['id'] = id;
    params['name'] = name;
    params['surname'] = surname;
    params['cf'] = cf;
    params['aId'] = activityId;
    if (email != null) {
      params['email'] = email!;
    }
    final uri = Uri.https(authority, '/profile/$id', params);
    return uri.toString();
  }

  String get fullName => '$name $surname';

  List toCsvList() {
    return [
      name,
      surname,
      cf,
    ];
  }
}

@freezed
class EventUser with _$EventUser {
  const factory EventUser({
    required String id,
    String? name,
    String? surname,
    String? cf,
    String? email,
    String? privateId,
    required bool fromExternalOrganization,
    @MyDateTimeConverter() DateTime? checkInAt,
    @MyDateTimeConverter() DateTime? checkOutAt,
  }) = _EventUser;

  factory EventUser.fromJson(Map<String, Object?> json) =>
      _$EventUserFromJson(json);
}

extension EventUserX on EventUser{
  String get fullName {
    if(name == null) {
      return id;
    }
    return '$name $surname';
  }

  List toCsvList() {
    return [
      name,
      surname,
      cf,
    ];
  }
}
