/*
import 'dart:math';

import 'package:countmein/src/totem/application/embedded_notifier.dart';
import 'package:countmein/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class EmbeddedScreen extends ConsumerWidget {
  final String totemId;
  final String eventId;

  final String sessionId;
  final String providerId;

  const EmbeddedScreen({
    super.key,
    required this.totemId,
    required this.eventId,
    required this.sessionId,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref
        .watch(getTotemDataProvider(providerId, eventId, sessionId, totemId));
    final size = MediaQuery.sizeOf(context);
    final width = min(size.width, size.height) / 2;
    return Scaffold(
      body: Center(
        child: state.when(
          data: (data) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Scansioni: ${data.count}'),
              const SizedBox(height: 16),
              SizedBox(
                width: width,
                height: width,
                child: QrImageView(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  data:
                      'https://link.wom.social/cmi/$providerId/$eventId/$totemId${data.requestId != null ? '/${data.requestId}' : ''}',
                ),
              ),
              const SizedBox(height: 16),
              Text('aggiornato il ${data.updatedOn.format}'),
            ],
          ),
          error: (e, s) => Text(e.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
*/
