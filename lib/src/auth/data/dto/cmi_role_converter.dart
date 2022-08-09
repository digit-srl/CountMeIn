import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

class CMIRoleConverter implements JsonConverter<PlatformRole, String?> {
  const CMIRoleConverter();

  @override
  PlatformRole fromJson(String? role) {
    if (role == null) return PlatformRole.unknown;
    try {
      return enumFromString(role, PlatformRole.values);
    } catch (ex) {
      return PlatformRole.unknown;
    }
  }

  @override
  String toJson(PlatformRole role) => enumToString(role) ?? 'unknown';
}

class UserRoleConverter implements JsonConverter<UserRole, String?> {
  const UserRoleConverter();

  @override
  UserRole fromJson(String? role) {
    if (role == null) return UserRole.unknown;
    try {
      return enumFromString(role, UserRole.values);
    } catch (ex) {
      return UserRole.unknown;
    }
  }

  @override
  String toJson(UserRole role) => enumToString(role) ?? 'unknown';
}