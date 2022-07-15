import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/domain/entities/session.dart';
import 'package:countmein/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'date_time_converter.dart';

part 'cmi_provider.freezed.dart';

part 'cmi_provider.g.dart';

enum CMIProviderStatus { unknown, pending, live, archived }

@freezed
class CMIProvider with _$CMIProvider {
  const factory CMIProvider({
    required String id,
    required String name,
    required String adminName,
    required String adminSurname,
    required String adminEmail,
    String? womApiKey,
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

extension CMIProviderX on CMIProvider{
  String get adminFullName => '$adminName $adminSurname';
}