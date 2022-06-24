import 'package:flutter/material.dart';

class UserConsoleScreen extends StatefulWidget {

  static const routeName = '/console';
  final String userId;
  const UserConsoleScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserConsoleScreen> createState() => _UserConsoleScreenState();
}

class _UserConsoleScreenState extends State<UserConsoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('USerID : ${widget.userId}'),),
    );
  }
}
