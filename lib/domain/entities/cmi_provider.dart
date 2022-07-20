import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/domain/entities/session.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart' show Color, Colors;
import 'package:freezed_annotation/freezed_annotation.dart';

import 'date_time_converter.dart';

part 'cmi_provider.freezed.dart';

part 'cmi_provider.g.dart';

enum CMIProviderStatus { unknown, pending, live, archived }
enum ProviderManagerStatus { unknown, pending, active, }

@freezed
class CMIProvider with _$CMIProvider {
  const factory CMIProvider({
    required String id,
    required String name,
    required String adminName,
    required String adminSurname,
    required String adminEmail,
    Map<String,ProviderManagerDTO>? managers,
    String? apiKey,
    List<String>? aims,
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
class ProviderManagerDTO with _$ProviderManagerDTO {
  const factory ProviderManagerDTO({
    required String name,
    @MyDateTimeConverter() DateTime? invitedOn,
    @ManagerStatusConverter() required ProviderManagerStatus status,
  }) = _ProviderManagerDTO;

  factory ProviderManagerDTO.fromJson(Map<String, Object?> json) =>
      _$ProviderManagerDTOFromJson(json);
}

class CMIProviderStatusConverter implements JsonConverter<CMIProviderStatus, String> {
  const CMIProviderStatusConverter();

  @override
  CMIProviderStatus fromJson(String? status) {
    if(status == null){
      return CMIProviderStatus.unknown;
    }
    return enumFromString(status, CMIProviderStatus.values);
  }

  @override
  String toJson(CMIProviderStatus status) => enumToString(status);
}

class ManagerStatusConverter implements JsonConverter<ProviderManagerStatus, String> {
  const ManagerStatusConverter();

  @override
  ProviderManagerStatus fromJson(String? status) {
    if(status == null){
      return ProviderManagerStatus.unknown;
    }
    return enumFromString(status, ProviderManagerStatus.values);
  }

  @override
  String toJson(ProviderManagerStatus status) => enumToString(status);
}

extension CMIProviderX on CMIProvider{
  String get adminFullName => '$adminName $adminSurname';
}

extension ProviderManagerStatusX on ProviderManagerStatus{
  Color get color{
    switch(this){
      case ProviderManagerStatus.unknown:
        return Colors.grey;
      case ProviderManagerStatus.pending:
        return Colors.orange;
      case ProviderManagerStatus.active:
        return Colors.green;
    }
  }
}