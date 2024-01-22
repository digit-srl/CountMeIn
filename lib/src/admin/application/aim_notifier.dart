import 'package:countmein/constants.dart';
import 'package:dart_wom_connector/dart_wom_connector.dart' show Aim, RegistryClient;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'aim_notifier.g.dart';

@Riverpod(keepAlive: true)
Future<List<Aim>> getAims(GetAimsRef ref) async {
  final client =  RegistryClient(womDomain);
  return await client.getAims();
}
