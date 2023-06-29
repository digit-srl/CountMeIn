
class Environment {
  static const launchMode = String.fromEnvironment('launchMode');
  static const isEmulator = launchMode == 'emulator';
}