import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/constants.dart';
import 'package:countmein/domain/entities/user_ids.dart';
import 'package:countmein/src/admin/application/confirm_invite.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/common/domain/entities/gender.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/src/user/application/user_card_recovering_notifier.dart';
import 'package:countmein/src/user/application/user_profile_notifier.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileDataWidget extends HookConsumerWidget {
  final UserIds userIds;

  const UserProfileDataWidget({
    Key? key,
    required this.userIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState<bool>(false);
    final hideCardRequest = useState<bool>(false);
    final userData = ref.watch(userProfileStreamProvider(userIds)).value;
    return CMICard(
      animated: true,
      child: loading.value
          ? const LoadingWidget()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoText(
                  label: 'Nome',
                  value: userData?.name,
                ),
                InfoText(
                  label: 'Cognome',
                  value: userData?.surname,
                ),
                InfoText(
                  label: 'Email',
                  value: userData?.email,
                ),
                InfoText(
                  label: 'C.F.',
                  value: userData?.cf,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: userData != null && !hideCardRequest.value
                      ? () async {
                          final gender = await showDialog(
                              context: context,
                              builder: (c) {
                                return const Dialog(
                                  child: GenderRequestWidget(),
                                );
                              });
                          if (gender != null) {
                            loading.value = true;
                            try {
                              final res = await ref.read(dioProvider).post(
                                recoverUserCardUrl,
                                data: {
                                  'userId': userIds.userId,
                                  'providerId': userIds.providerId,
                                  'cf': userData.cf,
                                  'gender': enumToString(gender)
                                },
                              );
                              loading.value = false;
                              if (res.statusCode == 200) {
                                // final map = Map<String, dynamic>.from(res.data);
                                //state = UserCardRecoveringProfile(ids: ids);
                                // showDialog(context: context, builder: (){return })
                                hideCardRequest.value =true;
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    title: 'Tesserino inviato',
                                    width: 300);
                              } else {
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    title: 'Si è verificato un errore',
                                    width: 300);
                              }
                            } catch (ex, st) {
                              print(ex);
                              print(st);
                              rethrow;
                            }
                          }
                        }
                      : null,
                  child: const Text('Richiedi tesserino'),
                )
              ],
            ),
    );
  }
}

class GenderRequestWidget extends HookConsumerWidget {
  const GenderRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = useState<Gender?>(null);
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Indica il genere percepito'),
          const SizedBox(height: 16),
          CMIDropdownButton<Gender>(
            label: 'Sesso percepito',
            validator: (v) {
              if (v == null) {
                return 'Questo campo è obbligatorio';
              }
              return null;
            },
            value: selectedGender.value,
            onChanged: (v) {
              if (v == null) return;
              selectedGender.value = v;
            },
            items: Gender.values
                .map((e) =>
                    DropdownMenuItem<Gender>(value: e, child: Text(e.text)))
                .toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: selectedGender.value != null
                  ? () {
                      Navigator.of(context).pop(selectedGender.value);
                    }
                  : null,
              child: const Text('Conferma')),
        ],
      ),
    );
  }
}
