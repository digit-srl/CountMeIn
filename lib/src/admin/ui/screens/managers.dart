import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:countmein/src/common/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../cloud.dart';
import '../../../../ui/widgets/loading.dart';
import '../../../../utils.dart';
import '../../../common/ui/widgets/cmi_container.dart';

final pendingInviteStreamProvider =
    StreamProvider.family<List<PendingProviderManager>, String>(
        (ref, providerId) async* {
  final stream = Cloud.pendingInviteCollection(providerId)
      .where('status', isEqualTo: 'pending')
      .snapshots();

  await for (final snap in stream) {
    try {
      final list = snap.docs.map((doc) {
        final s = PendingProviderManager.fromJson(doc.data());
        return s;
      }).toList();
      yield list;
    } catch (ex, st) {
      print(ex);
      print(st);
      yield <PendingProviderManager>[];
    }
  }
});

final selectedRoleProvider = StateProvider.autoDispose<UserRole>((ref) {
  return UserRole.collaborator;
});

class ManagersHandlerScreen extends StatefulHookConsumerWidget {
  static const String routeName = '/managers';
  final CMIProvider provider;

  const ManagersHandlerScreen({Key? key, required this.provider})
      : super(key: key);

  @override
  ConsumerState<ManagersHandlerScreen> createState() =>
      _ManagersHandlerScreenState();
}

class _ManagersHandlerScreenState extends ConsumerState<ManagersHandlerScreen> {
  final _formKey = GlobalKey<FormState>();
  bool addingMode = false;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final selectedRole = ref.watch(selectedRoleProvider);
    final state = ref.watch(pendingInviteStreamProvider(widget.provider.id));

    return Scaffold(
      appBar: AdminAppBar(
        title: 'Managers',
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.all(16.0),
          // alignment:Alignment.center,
          child: CMICard(
            child: state.when(
              data: (list) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Spacer(),
                          MUButton(
                            text: 'Aggiungi membro',
                            onPressed: () {
                              setState(() {
                                addingMode = true;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(flex: 2, child: Text('Membro')),
                          Expanded(child: Text('Ruolo')),
                          Expanded(flex: 2, child: Text('Email')),
                          Spacer(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      if (addingMode)
                        Container(
                          height: 55,
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: MUTextField(
                                  paddingTop: 0,
                                  hintText: 'Nome',
                                  controller: nameController,
                                  validator: textValidator,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                flex: 2,
                                child: MUTextField(
                                  paddingTop: 0,
                                  hintText: 'Email',
                                  controller: emailController,
                                  validator: emailValidator,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                  flex: 1,
                                  child: InputDecorator(
                                    decoration: InputDecoration(),
                                    child: DropdownButton<UserRole>(
                                      value: selectedRole,
                                      items: UserRole.values
                                          .map((e) =>
                                              DropdownMenuItem<UserRole>(
                                                  value: e,
                                                  child: Text(enumToString(e))))
                                          .toList(),
                                      onChanged: (role) {
                                        if (role == null) return;
                                        ref
                                            .read(selectedRoleProvider.notifier)
                                            .state = role;
                                      },
                                    ),
                                  )),
                              const SizedBox(width: 16),
                              MUButton(
                                text: 'Invita',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final email = emailController.text.trim();
                                    final name = nameController.text.trim();
                                    final newManager = PendingProviderManager(
                                      id: const Uuid().v4(),
                                      role: selectedRole,
                                      name: name,
                                      status: ProviderManagerStatus.pending,
                                      invitedOn: DateTime.now(),
                                      email: email,
                                      secret: '',
                                      providerName: widget.provider.name,
                                    );

                                    try {
                                      await Cloud.pendingInviteCollection(
                                              widget.provider.id)
                                          .doc(newManager.id)
                                          .set(newManager.toJson());
                                      setState(() {
                                        addingMode = false;
                                      });
                                      nameController.clear();
                                      emailController.clear();
                                    } catch (ex) {
                                      print(ex);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      for (final m in widget.provider.managers!.values)
                        MemberRow(
                          name: m.name,
                          role: m.role,
                          email: m.email,
                          onDelete: () {
                            final managers = widget.provider.managers!;
                            managers.removeWhere((key, value) => key == m.id);
                            Cloud.providerCollection
                                .doc(widget.provider.id)
                                .update({'managers': managers});
                          },
                          status: ProviderManagerStatus.completed,
                        ),
                      for (final m in list)
                        MemberRow(
                          name: m.name,
                          email: m.email,
                          role: m.role,
                          subtitle: m.status == ProviderManagerStatus.pending
                              ? m.invitedOn.toString()
                              : null,
                          onDelete: () {
                            Cloud.pendingInviteCollection(widget.provider.id)
                                .doc(m.id)
                                .update({'status': 'deleted'});
                          },
                          status: m.status,
                        ),
                    ],
                  ),
                );
              },
              error: (err, st) {
                return Text(err.toString());
              },
              loading: () => const LoadingWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class MemberRow extends StatelessWidget {
  final Function()? onDelete;
  final String? subtitle;
  final String name;
  final String email;
  final UserRole role;
  final ProviderManagerStatus status;

  const MemberRow({
    Key? key,
    required this.name,
    required this.email,
    this.onDelete,
    this.subtitle,
    required this.status,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Text(
              name,
              textAlign: TextAlign.start,
            )),
        Expanded(
            flex: 1,
            child: Text(
              enumToString(role),
              textAlign: TextAlign.start,
            )),
        Expanded(
            flex: 2,
            child: InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: email));
                },
                child: Text(
                  email,
                  textAlign: TextAlign.start,
                ))),
        const SizedBox(width: 16),
        const Spacer(
          flex: 1,
        ),
        if (status != ProviderManagerStatus.completed)
          Chip(
            // labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            backgroundColor: status.color,
            label: Text(
              enumToString(status),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: onDelete,
        ),
      ],
    );
  }
}
