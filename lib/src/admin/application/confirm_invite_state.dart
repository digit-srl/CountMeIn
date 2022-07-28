import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_invite_state.freezed.dart';

enum ConfirmInviteResponseStatus {
  completed,
  expired,
  deletedFromOwner,
  alreadyConfirmed
}

extension ConfirmInviteResponseStatusX on ConfirmInviteResponseStatus{
  String get message{
    switch(this){
      case ConfirmInviteResponseStatus.completed:
        return 'Conferma completata';
      case ConfirmInviteResponseStatus.expired:
        return 'L\'invito è scaduto';
      case ConfirmInviteResponseStatus.deletedFromOwner:
        return 'L\'invito è stato annullato dal proprietario';
      case ConfirmInviteResponseStatus.alreadyConfirmed:
        return 'Hai già confermato questo invito';
    }
  }
}

@freezed
class ConfirmInviteState with _$ConfirmInviteState {
  const factory ConfirmInviteState.loading() = ConfirmInviteLoading;

  const factory ConfirmInviteState.inviteExpired() = InviteExpired;

  const factory ConfirmInviteState.userAlreadyRegistered() = UserAlreadyRegistered;

  const factory ConfirmInviteState.newUser() = NewUser;

  const factory ConfirmInviteState.response(ConfirmInviteResponseStatus status) = ConfirmResponse;

  const factory ConfirmInviteState.error(Object error,
      StackTrace st) = ConfirmInviteError;
}

@freezed
class InviteRequest with _$InviteRequest {
  const factory InviteRequest({
    required String providerId,
    String? userId,
    required String inviteId,
    required String providerName,
    required String secret,
  }) = _InviteRequest;

}
