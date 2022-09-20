import 'dart:math';

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
import 'package:countmein/ui/validators.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final showGroupCardForm = useState<bool>(false);
    final userData = ref.watch(userProfileStreamProvider(userIds)).value;
    return CMICard(
      animated: true,
      child: loading.value
          ? const LoadingWidget()
          : showGroupCardForm.value
              ? GroupCardForm(
                  onSubmit: (groupName, groupCount, averageAge, manPercentage,
                      womanPercentage) async {
                    loading.value = true;

                    final res = await ref.read(dioProvider).post(
                      groupCardUrl,
                      data: {
                        "groupName": groupName,
                        "providerId": userIds.providerId,
                        "userId": userIds.userId,
                        "groupCount": groupCount,
                        "averageAge": averageAge,
                        "womanPercentage": womanPercentage,
                        "manPercentage": manPercentage,
                      },
                    );

                    CoolAlert.show(
                      context: context,
                      width: 400,
                      type: res.statusCode == 200
                          ? CoolAlertType.success
                          : CoolAlertType.error,
                      text: res.statusCode == 200
                          ? ''
                          : 'Si è verificato un errore',
                      title: 'Tesserino inviato con successo',
                    );

                    showGroupCardForm.value = false;
                    loading.value = false;
                  },
                )
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
                                    hideCardRequest.value = true;
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
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: userData != null
                          ? () async {
                              showGroupCardForm.value = true;
                            }
                          : null,
                      child: const Text('Richiedi tesserino da accompagnatore'),
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

class GroupCardForm extends StatefulHookConsumerWidget {
  final Function()? onCancel;
  final Function(
    String groupName,
    int groupCount,
    int averageAge,
    double manPercentage,
    double womanPercentage,
  )? onSubmit;

  const GroupCardForm({
    Key? key,
    this.onCancel,
    this.onSubmit,
  }) : super(key: key);

  @override
  ConsumerState<GroupCardForm> createState() => _GroupFormCardState();
}

class _GroupFormCardState extends ConsumerState<GroupCardForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final groupNameController = useTextEditingController();
    final averageAgeController = useTextEditingController();
    final groupCountController = useTextEditingController();
    final manPercentage = useState<double>(0.5);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tesserino di gruppo',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 32),
            CMITextField(
              controller: groupNameController,
              hintText: 'Nome del gruppo',
              validator: nameSurnameValidator,
            ),
            const SizedBox(height: 16),
            CMITextField(
              controller: averageAgeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: averageAgeValidator,
              hintText: 'Età media',
            ),
            const SizedBox(height: 16),
            CMITextField(
              controller: groupCountController,
              keyboardType: TextInputType.number,
              hintText: 'Numero di partecipanti',
              validator: maxGroupCountValidator,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 24),
            Text(
              'Percentuale maschi/femmine',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10.0,
                trackShape: RoundedRectSliderTrackShape(),
                // activeTrackColor: Colors.purple.shade800,
                // inactiveTrackColor: Colors.p,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 14.0,
                  pressedElevation: 8.0,
                ),
                thumbColor: Colors.grey,
                // overlayColor: Colors.pink.withOpacity(0.2),
                // overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                // tickMarkShape: RoundSliderTickMarkShape(),
                // activeTickMarkColor: Colors.pinkAccent,
                inactiveTickMarkColor: Colors.transparent,
                activeTickMarkColor: Colors.lightBlue,
                inactiveTrackColor: Colors.pink,
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.grey,
                activeTrackColor: Colors.lightBlue,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              child: Slider(
                min: 0,
                max: 1,
                divisions: 20,
                // activeColor: Colors.lightBlue,
                // inactiveColor: Colors.pink,
                label: '${(manPercentage.value * 100).toStringAsFixed(0)} %',
                value: manPercentage.value,
                onChanged: (double value) {
                  manPercentage.value = value;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Maschi: ${(manPercentage.value * 100).toStringAsFixed(0)} %',
                  textAlign: TextAlign.center,
                )),
                Expanded(
                    child: Text(
                  'Femmine: ${(100 - manPercentage.value * 100).toStringAsFixed(0)} %',
                  textAlign: TextAlign.center,
                )),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: widget.onSubmit != null
                    ? () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final name = groupNameController.text.trim();
                          final count =
                              int.parse(groupCountController.text.trim());
                          final averageAge =
                              int.parse(averageAgeController.text.trim());

                          final manP = roundDouble(manPercentage.value,2);
                          final womanP = roundDouble(1 - manPercentage.value,2);
                          print(manP);
                          print(womanP);
                          widget.onSubmit?.call(
                            name,
                            count,
                            averageAge,
                            manP,
                            womanP,
                          );
                        }
                      }
                    : null,
                child: Text('Richiedi'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
