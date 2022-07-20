import 'dart:io';

import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:countmein/src/auth/ui/screens/auht_gate.dart';
import 'package:countmein/src/auth/ui/screens/auth.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:countmein/ui/screens/activities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:countmein/ui/screens/user_qr_code.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../domain/entities/session.dart';
import '../../domain/entities/user_card.dart';
import 'admin.dart';

/*class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && !Platform.isMacOS) {
      return const AuthGate();
    }

    return Container();
  }
}*/

class HomeWebScreen extends StatelessWidget {
  const HomeWebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: MUButton(
              text: 'Dashboard',
              onPressed: () {
                context.push(AdminDashboardScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Count Me In',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            /* ElevatedButton(onPressed: (){
              context.go('/activity/$passepartoutActivityId');
            }, child: Text('vai all evento')),*/
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (c, AsyncSnapshot<PackageInfo> snap) {
                return Text(snap.data?.version ?? '-');
              },
            ),
          ],
        ),
      ),
    );
  }
}
