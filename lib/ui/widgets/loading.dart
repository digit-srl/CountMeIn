import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 120,
        width: 120,
        child: Center(child: CircularProgressIndicator()),);
  }
}
