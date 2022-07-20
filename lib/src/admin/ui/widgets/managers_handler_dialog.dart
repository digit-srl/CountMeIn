import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:countmein/src/common/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../cloud.dart';
import '../../../../utils.dart';
import '../../../common/ui/widgets/cmi_container.dart';

class ManagersHandlerDialog extends StatefulHookWidget {
  final CMIProvider provider;

  const ManagersHandlerDialog({Key? key, required this.provider})
      : super(key: key);

  @override
  State<ManagersHandlerDialog> createState() => _ManagersHandlerDialogState();
}

class _ManagersHandlerDialogState extends State<ManagersHandlerDialog> {
  final _formKey = GlobalKey<FormState>();
  bool addingMode = false;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: CMICard(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'Managers',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          addingMode = true;
                        });
                      }),
                ],
              ),
              Divider(),
              if (addingMode)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: MUTextField(
                          hintText: 'Nome',
                          controller: nameController,
                          validator: textValidator,
                        ),
                      ), const SizedBox(width: 16),
                      Flexible(
                        child: MUTextField(
                          hintText: 'Email',
                          controller: emailController,
                          validator: emailValidator,
                        ),
                      ),
                       const SizedBox(width: 16),
                      MUButton(
                        text: 'Invita',
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text.trim();
                            final name = nameController.text.trim();
                            final managers = widget.provider.managers ??
                                <String, ProviderManagerDTO>{};
                            final newManagers = <String, dynamic>{};
                            for (final m in managers.keys) {
                              newManagers[m] = managers[m]?.toJson();
                            }
                            final newManager = ProviderManagerDTO(
                              name: name,
                              status: ProviderManagerStatus.pending,
                              invitedOn: DateTime.now(),
                            );

                            newManagers[email] = newManager.toJson();
                            try{
                              await Cloud.providerCollection
                                  .doc(widget.provider.id)
                                  .update({'managers': newManagers});
                              setState(() {
                                addingMode = false;
                              });
                              nameController.clear();
                              emailController.clear();
                            }catch(ex){
                              print(ex);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              for (final m in widget.provider.managers!.values)
                ListTile(
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {}),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(m.name),
                       const SizedBox(width: 16),
                      Chip(
                        // labelPadding: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        backgroundColor: m.status.color,
                        label: Text(enumToString(m.status),style: Theme.of(context).textTheme.caption,),
                      ),
                    ],
                  ),
                  subtitle: m.status == ProviderManagerStatus.pending &&
                          m.invitedOn != null
                      ? Text(m.invitedOn.toString())
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
