import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:countmein/domain/entities/date_time_converter.dart';

part 'cmi_provider_request.freezed.dart';

part 'cmi_provider_request.g.dart';

@freezed
class CMIProviderRequest with _$CMIProviderRequest {
  const factory CMIProviderRequest({
    required String id,
    required String adminName,
    required String adminSurname,
    required String adminEmail,
    required String adminCf,
    required String name,
    required String aim,
    required bool releaseWom,
    required String pIva,
    required Map<String, ProviderManager> managers,
    @CMIProviderStatusConverter() required CMIProviderStatus status,
    @MyDateTimeConverter() required DateTime requestedOn, String? apiKey,
    List<String>? aims,
    String? domainRequirement,
  }) = _CMIProviderRequest;

  factory CMIProviderRequest.fromJson(Map<String, Object?> json) =>
      _$CMIProviderRequestFromJson(json);
}

extension CMIProviderRequestX on CMIProviderRequest{
  String get adminFullName => '$adminName $adminSurname';
}