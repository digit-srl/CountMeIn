import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailNotVerifiedScreen extends StatelessWidget {

  const EmailNotVerifiedScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text('EmailNotVerified'),
        ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser?.reload();
            },
            child: const Text('RELOAD')),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('LOGOUT'))
      ],
    );
  }
}