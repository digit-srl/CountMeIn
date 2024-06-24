import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/src/auth/data/dto/cmi_role_converter.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart' show Color, Colors;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../src/auth/domain/entities/user.dart';
import 'date_time_converter.dart';

part 'cmi_provider.freezed.dart';

part 'cmi_provider.g.dart';

enum CMIProviderStatus { unknown, pending, live, archived }

enum ProviderManagerStatus { unknown, pending, completed, deleted, expired, invalid }

@freezed
class CMIProvider with _$CMIProvider {
  const factory CMIProvider({
    required String id,
    required String name,
    required String adminName,
    required String adminSurname,
    required String adminEmail,
    @Default(<String, ProviderManager>{}) Map<String, ProviderManager> managers,
    String? apiKey,
    List<String>? aims,
    String? aim,
    String? domainRequirement,
    @Default(false) bool releaseWom,
    @CMIProviderStatusConverter() CMIProviderStatus? status,
    @MyDateTimeConverter() DateTime? createdOn,
    @MyDateTimeConverter() required DateTime requestedOn,
  }) = _CMIProvider;

  factory CMIProvider.fromJson(Map<String, Object?> json) =>
      _$CMIProviderFromJson(json);
}

/*
@freezed
class ProviderManagersDTO with _$ProviderManagersDTO {
  const factory ProviderManagersDTO({
    required Map<String,>> name,
    required String status,
  }) = _ProviderManagersDTO;

  factory ProviderManagersDTO.fromJson(Map<String, Object?> json) =>
      _$ProviderManagersDTOFromJson(json);
}
*/

@freezed
class PendingProviderManager with _$PendingProviderManager {
  const factory PendingProviderManager({
    required String id,
    @UserRoleConverter() required UserRole role,
    required String name,
    required String secret,
    required String providerName,
    required String email,
    @MyDateTimeConverter() required DateTime invitedOn,
    @ManagerStatusConverter() required ProviderManagerStatus status,
    String? eventId,
  }) = _PendingProviderManager;

  factory PendingProviderManager.fromJson(Map<String, Object?> json) =>
      _$PendingProviderManagerFromJson(json);
}

@freezed
class ProviderManager with _$ProviderManager {
  const factory ProviderManager({
    required String id,
    required String name,
    required String email,
    @UserRoleConverter() required UserRole role,
  }) = _ProviderManager;

  factory ProviderManager.fromJson(Map<String, Object?> json) =>
      _$ProviderManagerFromJson(json);
}

class CMIProviderStatusConverter
    implements JsonConverter<CMIProviderStatus, String> {
  const CMIProviderStatusConverter();

  @override
  CMIProviderStatus fromJson(String? status) {
    if (status == null) {
      return CMIProviderStatus.unknown;
    }
    return enumFromString(status, CMIProviderStatus.values);
  }

  @override
  String toJson(CMIProviderStatus status) => enumToString(status) ?? 'unknown';
}

class ManagerStatusConverter
    implements JsonConverter<ProviderManagerStatus, String> {
  const ManagerStatusConverter();

  @override
  ProviderManagerStatus fromJson(String? status) {
    if (status == null) {
      return ProviderManagerStatus.unknown;
    }
    return enumFromString(status, ProviderManagerStatus.values);
  }

  @override
  String toJson(ProviderManagerStatus status) =>
      enumToString(status) ?? 'unknown';
}

extension CMIProviderX on CMIProvider {
  String get adminFullName => '$adminName $adminSurname';
}

extension ProviderManagerStatusX on ProviderManagerStatus {
  Color get color {
    switch (this) {
      case ProviderManagerStatus.unknown:
        return Colors.grey;
      case ProviderManagerStatus.pending:
        return Colors.pinkAccent;
      case ProviderManagerStatus.expired:
        return Colors.orange;
      case ProviderManagerStatus.deleted:
        return Colors.red;
      case ProviderManagerStatus.completed:
        return Colors.green;
      case ProviderManagerStatus.invalid:
        return Colors.grey;
    }
  }
}
