import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:countmein/src/admin/ui/screens/admin_provider_handler.dart';
import 'package:countmein/src/admin/ui/screens/admin_providers.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/admin/ui/widgets/generic_grid_view.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/src/admin/ui/screens/event_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ArchivedEventsScreen extends ConsumerWidget {
  static const String routeName = 'archived';
  final String providerId;

  const ArchivedEventsScreen({required this.providerId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsState = ref
            .watch(
                eventsStreamProvider(providerId, status: EventStatus.archived),)
            .valueOrNull ??
        [];
    return Scaffold(
      appBar: const AdminAppBar(
        title: 'Eventi archiviati',
      ),
      body: GenericGridViewBuilder(
        padding: const EdgeInsets.all(16.0),
        scroolEnabled: true,
        itemCount: eventsState.length,
        itemBuilder: (BuildContext context, int index) {
          final event = eventsState[index];
          return CMICard(
            center: true,
            onTap: () {
              final path =
                  '${AdminDashboardScreen.path}/${AdminProvidersScreen.routeName}/${AdminProviderHandlerScreen.routeName}/$providerId/${EventDetailsScreen.routeName}/${event.id}';

              context.go(path);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (kDebugMode)
                  FittedBox(
                    child: Text(
                      event.id,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
