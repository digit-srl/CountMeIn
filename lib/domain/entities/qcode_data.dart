import 'package:freezed_annotation/freezed_annotation.dart';

part 'qcode_data.freezed.dart';

@freezed
class QrCodeData with _$QrCodeData {
 const factory QrCodeData({
   required String providerId,
   required String name,
   required String surname,
   required String email,
   required String cf,
   String? extra,
}) = _QrCodeData;

}
