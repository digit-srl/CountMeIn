import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_ids.freezed.dart';

@freezed
class UserIds with _$UserIds {
  const factory UserIds({
    required String providerId,
    required String userId,
  }) = _UserIds;
}