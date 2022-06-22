import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

@freezed
abstract class AuthDTO with _$AuthDTO {
  factory AuthDTO({
    required String id,
  }) = _AuthDTO;

  factory AuthDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthDTOFromJson(json);
}

extension AuthDTOX on AuthDTO {
Auth toDomain() {
    return Auth(id: id);
  }
}
