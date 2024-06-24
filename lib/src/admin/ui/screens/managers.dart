import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/domain/entities/cmi_provider.dart';
import 'package:countmein/my_logger.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/providers_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/auth/ui/screens/sign_in.dart';
import 'package:countmein/src/common/ui/widgets/cmi_dropdown.dart';
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
      logger.i(ex);
      logger.i(st);
      yield <PendingProviderManager>[];
    }
  }
});

class ManagersHandlerScreen extends StatefulHookConsumerWidget {
  static const String routeName = 'managers';
  final String providerId;
  final String providerName;

  const ManagersHandlerScreen({
    required this.providerId,
    required this.providerName,
    super.key,
  });

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

    final selectedRole = useState(UserRole.admin);
    final selectedEvent = useState<CMIEvent?>(null);
    final provider =
        ref.watch(singleCMIProviderProvider(widget.providerId)).valueOrNull;
    final state = ref.watch(pendingInviteStreamProvider(widget.providerId));
    final events =
        ref.watch(eventsStreamProvider(widget.providerId)).valueOrNull ?? [];
    return Scaffold(
      appBar: const AdminAppBar(
        title: 'Managers',
      ),
      body: Center(
        child: Container(
          // color: Colors.green,
          constraints: const BoxConstraints(maxWidth: 600),
          margin: const EdgeInsets.all(24.0),
          // alignment:Alignment.center,
          child: provider != null
              ? state.when(
                  data: (pendingInvites) {
                    return Form(
                      key: _formKey,
                      child: ListView(
                        padding: const EdgeInsets.all(16.0),
                        children: [
                          const SizedBox(height: 8),
                          if (!addingMode)
                            Row(
                              children: [
                                const Spacer(),
                                MUButton(
                                  text: 'Nuovo membro',
                                  onPressed: () {
                                    setState(() {
                                      addingMode = !addingMode;
                                    });
                                  },
                                ),
                              ],
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: CMICard(
                                inverseColor: true,
                                // height: 55,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Text('Nuovo manager'),
                                    const SizedBox(height: 32),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: MUTextField(
                                            paddingTop: 0,
                                            hintText: 'Nome',
                                            maxLines: 1,
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
                                            maxLines: 1,
                                            controller: emailController,
                                            validator: emailValidator,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width: 300,
                                        child: CMIDropdownButton<UserRole>(
                                          value: selectedRole.value,
                                          items: UserRole.values
                                              .map(
                                                (e) =>
                                                    DropdownMenuItem<UserRole>(
                                                  value: e,
                                                  child: Text(e.text),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (role) {
                                            if (role == null) return;
                                            if (!collaboratorsEventRole
                                                .contains(role)) {
                                              selectedEvent.value = null;
                                            }
                                            selectedRole.value = role;
                                          },
                                        ),
                                      ),
                                    ),
                                    if (selectedRole.value ==
                                            UserRole.eventManager ||
                                        selectedRole.value ==
                                            UserRole.scanner) ...[
                                      const SizedBox(height: 16),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 300,
                                          child: CMIDropdownButton<CMIEvent>(
                                            value: selectedEvent.value,
                                            label: 'Seleziona l\'evento',
                                            items: events
                                                .map(
                                                  (e) => DropdownMenuItem<
                                                      CMIEvent>(
                                                    value: e,
                                                    child: Text(e.name),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (event) {
                                              if (event == null) return;
                                              selectedEvent.value = event;
                                            },
                                          ),
                                        ),
                                      ),
                                      if (selectedEvent.value == null)
                                        const Text(
                                          'Per i ruoli manager e scanner è obbligatorio selezionare l\'evento!',
                                          style: TextStyle(
                                            color: Colors.orange,
                                          ),
                                        ),
                                    ],
                                    const SizedBox(height: 32),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              addingMode = !addingMode;
                                            });
                                          },
                                          child: const Text('Annulla'),
                                        ),
                                        MUButton(
                                          text: 'Invita',
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (collaboratorsEventRole
                                                      .contains(
                                                    selectedRole.value,
                                                  ) &&
                                                  selectedEvent.value == null) {
                                                return;
                                              }

                                              final email =
                                                  emailController.text.trim();
                                              final name =
                                                  nameController.text.trim();
                                              try {
                                                await addCollaborator(
                                                  name,
                                                  email,
                                                  selectedRole.value,
                                                  selectedEvent.value?.id,
                                                );
                                                setState(() {
                                                  addingMode = false;
                                                });
                                                nameController.clear();
                                                emailController.clear();
                                              } catch (ex) {
                                                logger.e(ex);
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          const Divider(),
                          if (pendingInvites.isEmpty &&
                              provider.managers.isEmpty)
                            const Text(
                              'Non ci sono managers per questo provider',
                            )
                          else ...[
                            for (final m in pendingInvites)
                              MemberRow(
                                name: m.name,
                                email: m.email,
                                role: m.role,
                                eventId: m.eventId,
                                pending: true,
                                subtitle:
                                    m.status == ProviderManagerStatus.pending
                                        ? m.invitedOn.toString()
                                        : null,
                                onDelete: () {
                                  Cloud.pendingInviteCollection(provider.id)
                                      .doc(m.id)
                                      .update({'status': 'deleted'});
                                },
                                status: m.status,
                              ),
                            for (final m in provider.managers.values)
                              MemberRow(
                                name: m.name,
                                role: m.role,
                                eventId: null,
                                email: m.email,
                                onDelete: () {
                                  final batch =
                                      FirebaseFirestore.instance.batch();
                                  // Se il ruole è relativo all'evento bisogna rimuovere
                                  // il manager anche dal doc dell'evento
                                  // if (collaboratorsEventRole.contains(m.role)) {
                                  //   batch.update(
                                  //     Cloud.eventDoc(provider.id, m.eventId),
                                  //     {'managers.${m.id}': null},
                                  //   );
                                  // }

                                  final managers = <String, ProviderManager>{};
                                  managers.addAll(provider.managers);
                                  managers
                                      .removeWhere((key, value) => key == m.id);
                                  final map = <String, dynamic>{};
                                  for (final k in managers.keys) {
                                    map[k] = managers[k]!.toJson();
                                  }
                                  batch.update(
                                    Cloud.providerCollection.doc(provider.id),
                                    {'managers': map},
                                  );
                                  batch.commit();
                                },
                                status: ProviderManagerStatus.completed,
                              ),
                          ],
                        ],
                      ),
                    );
                  },
                  error: (err, st) {
                    return Text(err.toString());
                  },
                  loading: () => const LoadingWidget(),
                )
              : const LoadingWidget(),
        ),
      ),
    );
  }

  Future<void> addCollaborator(
    String name,
    String email,
    UserRole role,
    String? eventId,
  ) async {
    final newManager = PendingProviderManager(
      id: const Uuid().v4(),
      role: role,
      name: name,
      status: ProviderManagerStatus.pending,
      invitedOn: DateTime.now(),
      email: email,
      secret: '',
      providerName: widget.providerName,
      eventId: eventId,
    );

    await Cloud.pendingInviteCollection(
      widget.providerId,
    ).doc(newManager.id).set(newManager.toJson());
  }
}

enum ManagerAction { copyEmail, delete }

class MemberRow extends StatelessWidget {
  final Function()? onDelete;
  final String? subtitle;
  final String name;
  final String email;
  final String? eventId;
  final UserRole role;
  final bool pending;
  final ProviderManagerStatus status;

  const MemberRow({
    Key? key,
    required this.name,
    required this.eventId,
    this.pending = false,
    required this.email,
    this.onDelete,
    this.subtitle,
    required this.status,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(role.text)),
                if (pending)
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'PENDING',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const Spacer(),
                PopupMenuButton<ManagerAction>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (ManagerAction item) async {
                    switch (item) {
                      case ManagerAction.copyEmail:
                        Clipboard.setData(ClipboardData(text: email));
                        showCustomToast('Email copiata negli appunti');
                        return;
                      case ManagerAction.delete:
                        final res = await ask(
                          context,
                          'Sicuro di voler ${pending ? 'revocare l\'invito di' : 'rimuovere'} $name dai manager?',
                        );
                        if (res ?? false) {
                          onDelete?.call();
                        }
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<ManagerAction>>[
                    const PopupMenuItem<ManagerAction>(
                      value: ManagerAction.copyEmail,
                      child: Text('Copia email'),
                    ),
                    PopupMenuItem<ManagerAction>(
                      enabled: !collaboratorsEventRole.contains(role),
                      value: ManagerAction.delete,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.red),
                      child: Text(pending ? 'Revoca invito' : 'Elimina'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              email,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            enumToString(role) ?? '-',
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: email));
            },
            child: Text(
              email,
              textAlign: TextAlign.start,
            ),
          ),
        ),
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
              enumToString(status) ?? '-',
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
