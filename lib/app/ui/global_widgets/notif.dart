import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:nemo/app/ui/utils/global_context.dart';

notifAction(
    {DialogType type = DialogType.warning,
    title,
    desc,
    required VoidCallback btnOK,
    required VoidCallback btnCancel,
    cancelText = 'No',
    okText = 'Yes'}) {
  AwesomeDialog(
    context: GlobalService.navigatorKey.currentState!.overlay!.context,
    dialogType: type,
    headerAnimationLoop: false,
    animType: AnimType.topSlide,
    showCloseIcon: false,
    dismissOnBackKeyPress: false,
    dismissOnTouchOutside: false,
    title: title,
    desc: desc,
    btnCancelText: cancelText,
    btnCancelOnPress: btnCancel,
    btnOkText: okText,
    btnOkOnPress: btnOK,
  ).show();
}

notif(message, {isi = '', tipe = '', Function(DismissType)? onDismissCallback}) {
  AwesomeDialog(
    autoHide: const Duration(seconds: 2),
    context: GlobalService.navigatorKey.currentState!.overlay!.context,
    dialogType: tipe == 'success' ? DialogType.success : DialogType.error,
    headerAnimationLoop: false,
    animType: tipe == 'success' ? AnimType.leftSlide : AnimType.topSlide,
    showCloseIcon: false,
    // dismissOnBackKeyPress: false,
    dismissOnTouchOutside: false,
    body: Column(
      children: [
        Text(
          tipe == 'success' ? 'Success' : 'Attention',
          style: const TextStyle(fontSize: 25),
        ),
        Text(
          message,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          isi,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    ),
    btnOkOnPress: () {},
    onDismissCallback: onDismissCallback,
  ).show();
}
