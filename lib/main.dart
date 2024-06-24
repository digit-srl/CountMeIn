import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:countmein/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:countmein/firebase_options.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'package:intl/date_symbol_data_local.dart';

enum AppFlavor { master, collab }

// fvm flutter build web --web-renderer canvaskit
// firebase deploy --only hosting
// firebase deploy --only functions:userSignUp-requestGroupCard
// firebase hosting:channel:deploy preview_name
// fvm flutter build apk
// firebase emulators:start --import=./emulator_backup --export-on-exit
// lsof -i tcp:8082

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeDateFormatting('it_IT');
  if (Environment.isEmulator) {
    const d = 'localhost';
    await FirebaseAuth.instance.useAuthEmulator(d, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(d, 8082);
  }

  if (kIsWeb) {
    // await FirebaseFirestore.instance
    //     .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  } else {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
      // cacheSizeBytes: 40,
    );
  }

  await Hive.openBox('user');
  setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}
