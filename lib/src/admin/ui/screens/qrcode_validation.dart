import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/widgets/my_text_field.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class QrCodeValidationString extends StatefulHookConsumerWidget {
  static const String routeName = '/qrCodeValidation';
  const QrCodeValidationString({Key? key}) : super(key: key);

  @override
  ConsumerState<QrCodeValidationString> createState() => _State();
}

class _State extends ConsumerState<QrCodeValidationString> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Scaffold(
      appBar: AdminAppBar(title: 'Valida qr code',),
      body: Center(
        child: CMICard(
          constraints: BoxConstraints(maxWidth: 700),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CMITextField(
                  textStyle:Theme.of(context).textTheme.bodyText2,
                  controller: controller,
                  hintText: 'Ex: providerId;name;surname;cf;extra;email',
                  validator: (value) {
                    if (value == null) return null;
                    final qrCodeData = validateCustomQrCode(value);
                    if(qrCodeData!= null){
                      return null;
                    }
                    return 'QrCode non valido';
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {}
                  },
                  child: Text('Valida'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
