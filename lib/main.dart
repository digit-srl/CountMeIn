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

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


enum AppFlavor { master, collab }

// fvm flutter build web --web-renderer canvaskit
// firebase hosting:channel:deploy preview_name
// firebase deploy --only functions
// fvm flutter build apk --dart-define=DEFINE_APP_NAME=+CountMeInMaster --dart-define=DEFINE_APP_SUFFIX=.master --dart-define=DEFINE_FLAVOR=master
// fvm flutter build apk --dart-define=DEFINE_APP_NAME=CountMeIn --dart-define=DEFINE_APP_SUFFIX=.collab --dart-define=DEFINE_FLAVOR=collab
// firebase emulators:start --import=./emulator_backup --export-on-exit

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8082);
  }

  if (kIsWeb) {
    await FirebaseFirestore.instance
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  } else {
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  }
  await Hive.openBox('user');
  setPathUrlStrategy();
  runApp(ProviderScope(child: MyApp()));
}

