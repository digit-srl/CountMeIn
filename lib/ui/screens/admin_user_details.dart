import 'package:flutter/material.dart';

import '../../domain/entities/user_card.dart';

class UserDetailsScreen extends StatelessWidget {
  static const routeName = '/userDetails';

  final UserCard user;

  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            UserField(
              field: 'Nome',
              value: user.name,
            ),
            UserField(
              field: 'Cognome',
              value: user.surname,
            ),
            UserField(
              field: 'C.F.',
              value: user.cf,
            ),
          ],
        ),
      ),
    );
  }
}

class UserField extends StatelessWidget {
  final String field;
  final String value;

  const UserField({Key? key, required this.field, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            field,
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
