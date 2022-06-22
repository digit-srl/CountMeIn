import 'package:countmein/main.dart';

const flavor = String.fromEnvironment('DEFINE_FLAVOR') == 'collab'
    ? AppFlavor.collab
    : AppFlavor.master;

final isMaster = flavor == AppFlavor.master;
const qrCodePrefix = 'cmi';
const baseUrl = 'https://comein.digit.srl';
