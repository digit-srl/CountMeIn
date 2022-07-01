import 'package:countmein/main.dart';

const flavor = String.fromEnvironment('DEFINE_FLAVOR') == 'collab'
    ? AppFlavor.collab
    : AppFlavor.master;

final isMaster = flavor == AppFlavor.master;
const qrCodePrefix = 'cmi';
const authority = 'cmi.digit.srl';
const baseUrl = 'https://$authority';
const passepartoutActivityId = 'wom-count-me-in';
