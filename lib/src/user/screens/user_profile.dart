import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/user/application/user_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UserConsoleScreen extends ConsumerStatefulWidget {
  static const routeName = '/profile';
  final String userId;

  const UserConsoleScreen({Key? key, required this.userId}) : super(key: key);

  @override
  ConsumerState<UserConsoleScreen> createState() => _UserConsoleScreenState();
}

class _UserConsoleScreenState extends ConsumerState<UserConsoleScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProfileNotifierProvider(widget.userId));
    return Scaffold(
      body: Center(
        child: CMICard(
          child: state.when(
            initial: () {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        'Richiedi il codice otp per accedere al tuo profilo'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          ref
                              .read(userProfileNotifierProvider(widget.userId)
                                  .notifier)
                              .getOtpCode();
                        },
                        child: const Text('Richiedi codice')),
                  ],
                ),
              );
            },
            loading: () {
              return const CircularProgressIndicator();
            },
            error: (ex, st) {
              return Text(ex.toString());
            },
            waitingOtpCode: () {
              return WaitingOtpCode(
                userId: widget.userId,
              );
            },
            wrongCode: () {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Otp non valido'),
                  ElevatedButton(
                      onPressed: () {
                        ref
                            .read(userProfileNotifierProvider(widget.userId)
                                .notifier)
                            .reset();
                      },
                      child: Text('Riprova')),
                ],
              );
            },
            data: (String userId) {
              return UserProfileDataWidget(userId: userId);
            },
          ),
        ),
      ),
    );
  }
}

class UserProfileDataWidget extends ConsumerWidget {
  final String userId;

  const UserProfileDataWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProfileStreamProvider(userId)).value;
    return CMICard(
      child: Column(
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
            label: 'C.F.',
            value: userData?.cf,
          ),
        ],
      ),
    );
  }
}

class WaitingOtpCode extends StatefulHookConsumerWidget {
  final String userId;

  const WaitingOtpCode({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  ConsumerState createState() => _WaitingOtpCodeState();
}

class _WaitingOtpCodeState extends ConsumerState<WaitingOtpCode> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final errorController = useStreamController<ErrorAnimationType>();
    final textController = useTextEditingController();
    final hasError = useState(false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
            'Inserisci il codice OTP ricevuto per email all\'indirizzo '),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: formKey,
            child: PinCodeTextField(
              appContext: context,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 5,
              obscureText: false,
              obscuringCharacter: '*',
              animationType: AnimationType.fade,
              validator: (v) {
                if (v == null) return null;
                if (v.length < 3) {
                  return "I'm from validator";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 60,
                fieldWidth: 50,
                activeFillColor: hasError.value ? Colors.orange : Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              textStyle: Theme.of(context).textTheme.headline6,
              // backgroundColor: Colors.blue.shade50,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textController,
              keyboardType: TextInputType.number,
              /*boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],*/
              onCompleted: (v) {
                print("Completed");
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                print(value);
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            hasError.value ? "*Please fill up all the cells properly" : "",
            style: const TextStyle(
                color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(height: 24),
        /*   RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Didn't receive the code? ",
              style: const TextStyle(color: Colors.black54, fontSize: 15),
              children: [
                TextSpan(
                    text: " RESEND",
                    recognizer: onTapRecognizer,
                    style: const TextStyle(
                        color: Color(0xFF91D3B3),
                        fontWeight: FontWeight.bold,
                        fontSize: 16))
              ]),
        ),
        const SizedBox(
          height: 14,
        ),*/
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              final currentText = textController.text.trim();
              if (currentText.length != 5) {
                errorController.add(ErrorAnimationType
                    .shake); // Triggering error shake animation
                hasError.value = true;
              } else {
                hasError.value = false;
                ref
                    .read(userProfileNotifierProvider(widget.userId).notifier)
                    .verifyOtpCode(currentText);
              }
            }
          },
          child: Text(
            "VERIFY".toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: const Text("Clear"),
              onPressed: () {
                textController.clear();
              },
            ),
            FlatButton(
              child: const Text("Set Text"),
              onPressed: () {
                textController.text = "123456";
              },
            ),
          ],
        )
      ],
    );
  }
}
