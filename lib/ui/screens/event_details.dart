import 'dart:io';

import 'package:countmein/src/admin/ui/screens/event_users.dart';
import 'package:countmein/src/admin/ui/widgets/info_text.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/screens/activities.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:countmein/cloud.dart';
import 'package:countmein/ui/screens/scan.dart';

import '../../application/activity_notifier.dart';
import '../../constants.dart';
import '../../domain/entities/cmi_provider.dart';
import '../../domain/entities/event_ids.dart';
import '../../domain/entities/session.dart';
import '../../domain/entities/user_card.dart';
import '../../src/auth/domain/entities/user.dart';
import '../../utils.dart';
import '../widgets/add_session_dialog.dart';
import '../widgets/loading.dart';
import 'admin.dart';
import 'admin_user_details.dart';
import 'user_event.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  static const String routeName = '/eventDetails';

  final String eventId;
  final String providerId;

  const EventDetailsScreen({
    Key? key,
    required this.eventId,
    required this.providerId,
  }) : super(key: key);

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  late EventIds ids;

  @override
  void initState() {
    super.initState();
    ids = EventIds(activityId: widget.providerId, eventId: widget.eventId);
  }

  _goToScan(CMIProvider activity, Event event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ScanScreen(
          event: event,
          activity: activity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventState =
        ref.watch(eventProvider([widget.providerId, widget.eventId]));
    final eventData = eventState.asData?.value;
    final activityState = ref.watch(activityStreamProvider(widget.providerId));
    final role = ref.watch(userRoleProvider(widget.providerId));
    final isOwner = role == UserRole.admin;

    return Scaffold(
      appBar: AppBar(
        title: Text(eventState.asData?.value.name ?? ''),
        actions: [
          if (eventData != null &&
              eventData.isOpen &&
              activityState is AsyncData<CMIProvider>) ...[
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _goToScan(activityState.asData!.value, eventData);
                }),
          ]
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CMICard(
            child: Column(
              children: [
                InfoText(
                  label: 'Nome Evento',
                  value: eventData?.name,
                ),
                InfoText(
                  label: 'ID evento',
                  value: eventData?.id,
                  copyable: true,
                ),
                InfoText(
                  label: 'WOM',
                  value: eventData?.womCount?.toString(),
                ),
                InfoText(
                  label: 'Stato',
                  value: enumToString(eventData?.status),
                ),
                InfoText(
                  label: 'Accetta passpartout',
                  value: eventData?.acceptPassepartout.toString(),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 4 / 3,
            children: [
              CMICard(
                onTap: () {
                  context.pushNamed(
                    EventUsersScreen.routeName,
                    params: {
                      'eventId': widget.eventId,
                      'providerId': widget.providerId
                    },
                  );
                },
                child: Text(
                  'Utenti',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
