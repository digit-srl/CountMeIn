import 'package:countmein/domain/entities/user_ids.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/user/application/user_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WaitingOtpCode extends StatefulHookConsumerWidget {
  final UserIds userIds;
  final Function(String otpCode)? verify;

  const WaitingOtpCode({
    Key? key,
    required this.userIds,
    required this.verify,
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
            'Inserisci il codice OTP ricevuto per email'),
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
              // obscureText: false,
              // obscuringCharacter: '*',
              animationType: AnimationType.fade,
              validator: (v) {
                return null;
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
                // activeColor: Colors.red,
                selectedColor: Colors.white,
                inactiveColor: Colors.white,
                disabledColor: Colors.grey,
                activeFillColor: hasError.value ? Colors.white : Colors.white,
                selectedFillColor: Colors.lightGreen,
                inactiveFillColor: Colors.grey,
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              textStyle: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),
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
                logger.i("Completed");
              },
              // onTap: () {
              //   logger.i("Pressed");
              // },
              onChanged: (value) {
                logger.i(value);
              },
              beforeTextPaste: (text) {
                logger.i("Allowing to paste $text");
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
            hasError.value ? "Inserisci il codice OTP di 5 cifre" : "",
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
                widget.verify?.call(currentText);
              }
            }
          },
          child: Text(
            "Verifica".toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
