import 'dart:math';

import 'package:countmein/src/features/create_events_batch/application/create_events_batch_notifier.dart';
import 'package:countmein/ui/widgets/cmi_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateEventsBatchScreen extends ConsumerWidget {
  static const String routeName = 'events-batch';

  final String providerId;

  const CreateEventsBatchScreen({
    required this.providerId, super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createEventsBatchNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea eventi e sessioni da un CSV'),
        actions: [
          ElevatedButton(
            onPressed: () {
              ref.read(createEventsBatchNotifierProvider.notifier).reset();
            },
            child: const Text('RESET'),
          ),
        ],
      ),
      body: switch (state) {
        CreateEventsBatchStateInitial() => const _ImportCsv(),
        CreateEventsBatchStateCsvEventsLoaded() => _CSVEventsLoaded(
            state: state,
          ),
        CreateEventsBatchStateGenerated() => _EventsGenerated(
            state: state,
            providerId: providerId,
          ),
        CreateEventsBatchStateCompleted() => const _CreationComplete(),
        _ => const CMIErrorWidget(),
      },
    );
  }
}

class _ImportCsv extends ConsumerWidget {
  const _ImportCsv();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BaseContainer(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            ref
                .read(createEventsBatchNotifierProvider.notifier)
                .importCSVEvents();
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
  final CreateEventsBatchStateCsvEventsLoaded state;

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
          Text(
            '${state.eventsFileName} - ${state.eventsCsv.length} righe',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(),
          for (int i = 0; i < min(state.eventsCsv.length, 5); i++)
            Text(
              state.eventsCsv[i].join('|'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          if (state.sessionsFileName != null && state.sessionsCsv != null) ...[
            const SizedBox(height: 16),
            Text(
              '${state.sessionsFileName} - ${state.sessionsCsv!.length} righe',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            for (int i = 0; i < min(state.sessionsCsv!.length, 5); i++)
              Text(
                state.sessionsCsv![i].join('|'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ElevatedButton(
              onPressed: () {
                ref.read(createEventsBatchNotifierProvider.notifier).generate();
              },
              child: const Text('Genera Eventi'),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(createEventsBatchNotifierProvider.notifier)
                        .importCSVSessions();
                  },
                  child: const Text('Importa CSV sessioni'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EventsGenerated extends ConsumerWidget {
  final CreateEventsBatchStateGenerated state;
  final String providerId;

  const _EventsGenerated({
    required this.providerId,
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
            '${state.list.length} eventi:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(),
          for (int i = 0; i < state.list.length; i++)
            ListTile(
                title: Row(
                  children: [
                    Text(state.list[i].event.name),
                    const Text(' | '),
                    Text('${state.list[i].event.maxWomCount.toString()} WOM'),
                    const Text(' | '),
                    Text(state.list[i].event.aim ?? '-'),
                  ],
                ),
                trailing: Text(state.list[i].sessions.length.toString()),
                subtitle: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...state.list[i].sessions
                        .map((e) => Chip(label: Text(e.name ?? ''))),
                  ],
                ),),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(createEventsBatchNotifierProvider.notifier)
                    .upload(providerId);
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
    ),);
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
