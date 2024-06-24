import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:countmein/constants.dart';
import 'package:countmein/domain/entities/user_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/confirm_invite.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/common/domain/entities/gender.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
import 'package:countmein/src/user/application/user_profile_notifier.dart';
import 'package:countmein/ui/validators.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileDataWidget extends HookConsumerWidget {
  final UserIds userIds;

  const UserProfileDataWidget({
    required this.userIds, super.key,
  });

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
                  onSubmit: (
                    groupName,
                    groupCount,
                    averageAge,
                    maleCount,
                    femaleCount,
                    manPercentage,
                    womanPercentage,
                  ) async {
                    loading.value = true;

                    final res = await ref.read(dioProvider).post(
                      groupCardUrl,
                      data: {
                        'groupName': groupName,
                        'providerId': userIds.providerId,
                        'userId': userIds.userId,
                        'groupCount': groupCount,
                        'averageAge': averageAge,
                        'maleCount':maleCount,
                        'femaleCount':femaleCount,
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
                      onPressed: userData != null //&& !hideCardRequest.value
                          ? () async {
                              final gender = await showDialog(
                                  context: context,
                                  builder: (c) {
                                    return const Dialog(
                                      child: GenderRequestWidget(),
                                    );
                                  },);
                              if (gender != null) {
                                loading.value = true;
                                try {
                                  final res = await ref.read(dioProvider).post(
                                    recoverUserCardUrl,
                                    data: {
                                      'userId': userIds.userId,
                                      'providerId': userIds.providerId,
                                      'cf': userData.cf,
                                      'gender': enumToString(gender),
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
                                        width: 300,);
                                  } else {
                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        title: 'Si è verificato un errore',
                                        width: 300,);
                                  }
                                } catch (ex, st) {
                                  logger.i(ex);
                                  logger.i(st);
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
                    ),
                  ],
                ),
    );
  }
}

class GenderRequestWidget extends HookConsumerWidget {
  const GenderRequestWidget({super.key});

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
            label: 'Genere percepito',
            validator: (v) {
              if (v == null) {
                return 'Campo obbligatorio';
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
                    DropdownMenuItem<Gender>(value: e, child: Text(e.text)),)
                .toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: selectedGender.value != null
                  ? () {
                      Navigator.of(context).pop(selectedGender.value);
                    }
                  : null,
              child: const Text('Conferma'),),
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
    int? averageAge,
    int? male,
    int? female,
    double? manPercentage,
    double? womanPercentage,
  )? onSubmit;

  const GroupCardForm({
    super.key,
    this.onCancel,
    this.onSubmit,
  });

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
    final sliderDivisions = useState<int?>(null);
    final sliderEnabled = useState<bool>(false);
    final maleCount =
        ((sliderDivisions.value ?? 1) * manPercentage.value).toStringAsFixed(0);
    final femaleCount =
        ((1 - manPercentage.value) * (sliderDivisions.value ?? 1))
            .toStringAsFixed(0);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tesserino di gruppo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
                'Ricorda che il tesserino di gruppo è valido solo se accompagnato dal tuo tesserino personale!',),
            const SizedBox(height: 32),
            CMITextField(
              controller: groupNameController,
              hintText: 'Nome del gruppo',
              validator: nameSurnameValidator.call,
            ),
            const SizedBox(height: 16),
            CMITextField(
              controller: averageAgeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: averageAgeValidator.call,
              hintText: 'Età media',
            ),
            const SizedBox(height: 16),
            CMITextField(
              controller: groupCountController,
              keyboardType: TextInputType.number,
              hintText: 'Numero di partecipanti',
              validator: maxGroupCountValidator.call,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (v) {
                sliderDivisions.value = int.tryParse(v);
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Percentuale maschi/femmine',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                    value: sliderEnabled.value,
                    onChanged: (v) {
                      if (v == null) return;
                      sliderEnabled.value = v;
                    },),
                const SizedBox(width: 16),
                const Text('Aggiungi info sul genere dei partecipanti'),
              ],
            ),
            if (sliderEnabled.value) ...[
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 10.0,
                  trackShape: const RoundedRectSliderTrackShape(),
                  // activeTrackColor: Colors.purple.shade800,
                  // inactiveTrackColor: Colors.p,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 14.0,
                    pressedElevation: 8.0,
                  ),
                  thumbColor: Colors.grey,
                  // overlayColor: Colors.pink.withOpacity(0.2),
                  // overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                  // tickMarkShape: RoundSliderTickMarkShape(),
                  // activeTickMarkColor: Colors.pinkAccent,
                  inactiveTickMarkColor: Colors.transparent,
                  activeTickMarkColor: Colors.yellow,
                  inactiveTrackColor: Colors.purple,
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Colors.grey,
                  activeTrackColor: Colors.yellow,
                  valueIndicatorTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                child: Slider(
                  min: 0,
                  max: 1,
                  divisions: sliderDivisions.value ?? 1,
                  // activeColor: Colors.lightBlue,
                  // inactiveColor: Colors.pink,
                  label: '${(manPercentage.value * 100).toStringAsFixed(0)} %',
                  value: manPercentage.value,
                  onChanged:
                      sliderDivisions.value == null || !sliderEnabled.value
                          ? null
                          : (double value) {
                              manPercentage.value = value;
                            },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Maschi: $maleCount',
                    // 'Maschi: ${(manPercentage.value * 100).toStringAsFixed(0)} %',
                    textAlign: TextAlign.center,
                  ),),
                  Expanded(
                    child: Text(
                      'Femmine: $femaleCount',
                      // 'Femmine: ${(100 - manPercentage.value * 100).toStringAsFixed(0)} %',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
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
                              int.tryParse(averageAgeController.text.trim());

                          final manP = roundDouble(manPercentage.value, 2);
                          final womanP =
                              roundDouble(1 - manPercentage.value, 2);
                          logger.i(manP);
                          logger.i(womanP);
                          widget.onSubmit?.call(
                            name,
                            count,
                            averageAge,
                            sliderEnabled.value
                                ? int.tryParse(maleCount)
                                : null,
                            sliderEnabled.value
                                ? int.tryParse(femaleCount)
                                : null,
                            sliderEnabled.value ? manP : null,
                            sliderEnabled.value ? womanP : null,
                          );
                        }
                      }
                    : null,
                child: const Text('Richiedi'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return (value * mod).round().toDouble() / mod;
  }
}
