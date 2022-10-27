import 'package:countmein/cloud.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_card.dart';

class UserDetailsScreen extends StatelessWidget {
  static const routeName = '/userDetails';

  final Function()? onDelete;
  final EventUser user;

  const UserDetailsScreen({
    Key? key,
    required this.user,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (user.isGroup)
              UserField(
                field: 'Nome Gruppo',
                value: user.groupName,
              ),
            UserField(
              field: user.isGroup ? 'Nome accompagnatore' : 'Nome',
              value: user.isGroup ? user.fullName : user.name,
            ),
            if (!user.isGroup)
              UserField(
                field: 'Cognome',
                value: user.surname,
              ),
            UserField(
              field: 'C.F.',
              value: user.cf,
            ),
            if (user.isGroup) ...[
              UserField(
                field: 'N. Componenti',
                value: user.groupCount?.toString(),
              ),
              UserField(
                field: 'Maschi',
                value: user.manPercentage != null
                    ? (user.manPercentage! * 100).toStringAsFixed(0)
                    : null,
              ),
              UserField(
                field: 'Femmine',
                value: user.womanPercentage != null
                    ? (user.womanPercentage! * 100).toStringAsFixed(0)
                    : null,
              ),
            ],
            // if (onDelete != null)
            //   ElevatedButton(
            //     onPressed: onDelete,
            //     child: Text('Elimina'),
            //   ),
          ],
        ),
      ),
    );
  }
}

class UserField extends StatelessWidget {
  final String field;
  final String? value;

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
            value ?? '-',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
