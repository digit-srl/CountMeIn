import 'package:countmein/domain/entities/user_ids.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_card_recovering_state.freezed.dart';

@freezed
class UserCardRecoveringState with _$UserCardRecoveringState {
  const factory UserCardRecoveringState.initial() = UserCardRecoveringInitial;
  const factory UserCardRecoveringState.loading() = UserCardRecoveringLoading;
  const factory UserCardRecoveringState.waitingOtpCode({required UserIds ids}) = UserCardRecoveringWaitingOtpCode;
  const factory UserCardRecoveringState.profile({required UserIds ids}) = UserCardRecoveringProfile;
  const factory UserCardRecoveringState.error({Object? error, StackTrace? st}) = UserCardRecoveringError;
}