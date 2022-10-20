import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

enum AppFlavor { master, collab }

// fvm flutter build web --web-renderer canvaskit
// firebase deploy --only hosting
// firebase deploy --only functions:onUserCheckIn
// firebase hosting:channel:deploy preview_name
// fvm flutter build apk
// firebase emulators:start --import=./emulator_backup --export-on-exit
// lsof -i tcp:8082

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    // final d = "localhost";
    // await FirebaseAuth.instance.useAuthEmulator(d, 9099);
    // FirebaseFirestore.instance.useFirestoreEmulator(d, 8082);
  }

  if (kIsWeb) {
    // await FirebaseFirestore.instance
    //     .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  } else {
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  }

  await Hive.openBox('user');
  setPathUrlStrategy();
  runApp(ProviderScope(child: MyApp()));
}
