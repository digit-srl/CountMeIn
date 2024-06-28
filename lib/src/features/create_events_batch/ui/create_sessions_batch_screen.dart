import 'dart:math';

import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/features/create_events_batch/application/create_sessions_batch_notifier.dart';
import 'package:countmein/ui/widgets/cmi_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateSessionsBatchScreen extends ConsumerWidget {
  static const String routeName = 'sessions-batch';

  final String eventId;
  final String providerId;

  const CreateSessionsBatchScreen({
    required this.eventId,
    required this.providerId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(
      eventProvider(
        EventIds(
          providerId: providerId,
          eventId: eventId,
        ),
      ),
    );
    final eventData = eventState.asData?.valueOrNull;
    if (eventData == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    final state = ref.watch(
      createSessionsBatchNotifierProvider(providerId, eventId),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea eventi e sessioni da un CSV'),
        actions: [
          ElevatedButton(
            onPressed: () {
              ref
                  .read(createSessionsBatchNotifierProvider(providerId, eventId)
                      .notifier)
                  .reset();
            },
            child: const Text('RESET'),
          ),
        ],
      ),
      body: switch (state) {
        CreateSessionsBatchStateInitial() => _ImportCsv(providerId, eventId),
        CreateSessionsBatchStateCsvSessionsLoaded() => _CSVEventsLoaded(
            state: state,
          ),
        CreateSessionsBatchStateGenerated() => _EventsGenerated(
            state: state,
          ),
        CreateSessionsBatchStateCompleted() => const _CreationComplete(),
        _ => const CMIErrorWidget(),
      },
    );
  }
}

class _ImportCsv extends ConsumerWidget {
  final String providerId;
  final String eventId;

  const _ImportCsv(
    this.providerId,
    this.eventId,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BaseContainer(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            ref
                .read(
                  createSessionsBatchNotifierProvider(providerId, eventId)
                      .notifier,
                )
                .importCSVSessions();
          },
          child: const Text(
            'Import file',
          ),
        ),
      ),
    );
  }
}

class _CSVEventsLoaded extends ConsumerWidget {
  final CreateSessionsBatchStateCsvSessionsLoaded state;

  const _CSVEventsLoaded({
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BaseContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            '${state.sessionsFileName} - ${state.sessionsCsv.length} righe',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(),
          for (int i = 0; i < min(state.sessionsCsv.length, 5); i++)
            Text(
              state.sessionsCsv[i].join('|'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(createSessionsBatchNotifierProvider(
                          state.providerId, state.eventId)
                      .notifier)
                  .generate();
            },
            child: const Text('Genera Eventi'),
          ),
        ],
      ),
    );
  }
}

class _EventsGenerated extends ConsumerWidget {
  final CreateSessionsBatchStateGenerated state;

  const _EventsGenerated({
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BaseContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${state.list.length} nuove sessioni:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            for (int i = 0; i < state.list.length; i++)
              ListTile(
                isThreeLine: true,
                title: Text(state.list[i].name ?? 'Nome'),
                subtitle: Text('${state.list[i].startAt}\n'
                    '${state.list[i].endAt}'),
              ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(createSessionsBatchNotifierProvider(
                              state.providerId, state.eventId)
                          .notifier)
                      .upload();
                },
                child: Center(
                  child: state.uploadInProgress
                      ? const CircularProgressIndicator()
                      : const Text('Upload'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreationComplete extends ConsumerWidget {
  const _CreationComplete();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _BaseContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          ),
          Text('Upload completed'),
        ],
      ),
    );
  }
}

class _BaseContainer extends StatelessWidget {
  final Widget child;

  const _BaseContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(
            minWidth: 500,
            minHeight: 300,
            maxWidth: 700,
            maxHeight: 600,
          ),
          child: child,
        ),
      ),
    );
  }
}
