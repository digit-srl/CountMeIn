import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart' hide Router;

class AlertUtils {
  static Future showStandardMessage(
    BuildContext context,
    String title, {
    String? desc,
    Function? onDone,
    Orientation? orientation = Orientation.landscape,
  }) async {
    await CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: title,
        widget: desc != null ? Text(desc) : null,
        onConfirmBtnTap: () {
          onDone?.call();
          Navigator.of(context, rootNavigator: true).pop();
        });
  }

/*  static Future<bool?> showCustomContentAlert(
    BuildContext context,
    Widget content,
  ) async {
    return Alert(
      context: context,
      style: const AlertStyle(
        isCloseButton: false,
        animationType: AnimationType.grow,
        animationDuration: const Duration(milliseconds: 100),
      ),
      content: content,
      title: '',
    ).show();
  }

  static Future<bool?> showConfirmAlert(
    BuildContext context,
    String title, {
    Function? onConfirm,
    Function? onExit,
    String? desc,
    Widget content = const SizedBox.shrink(),
    String onConfirmText = 'Sì',
    String onExitText = 'Annulla',
  }) async {
    return Alert(
      context: context,
      style: const AlertStyle(
        isCloseButton: false,
        animationType: AnimationType.grow,
        animationDuration: const Duration(milliseconds: 100),
      ),
      title: title,
      content: content,
      desc: desc,
      buttons: [
        DialogButton(
          color: Theme.of(context).cardColor,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(false);
          },
          child: Text(
            onExitText,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        DialogButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context, rootNavigator: true).pop(true);
          },
          child: Text(
            onConfirmText,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    ).show();
  }

  static showLoading(BuildContext context) async {
    await Alert(
        context: context,
        style: AlertStyle(isCloseButton: false),
        title: 'Caricamento',
        content: Center(
          child: CircularProgressIndicator(),
        )).show();
  }*/
}
