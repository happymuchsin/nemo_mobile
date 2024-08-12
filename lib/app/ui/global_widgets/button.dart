import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nemo/app/ui/global_widgets/decoration.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/utils/global_context.dart';

late AwesomeDialog xdialog;
XFile? globalImage;
final ImagePicker picker = ImagePicker();

exBtn(
    {flex = 1,
    VoidCallback? onPressed,
    Color backgroundColor = Colors.green,
    Color foregroundColor = Colors.white,
    isIcon = false,
    isText = false,
    IconData? icon,
    text,
    required type,
    isPadding = false,
    double fontSize = 20,
    double? iconSize,
    double? paddingLeft,
    double? paddingTop,
    double? paddingRight,
    double? paddingBottom,
    isTextExpanded = false}) {
  return Expanded(
    flex: flex,
    child: btn(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      isIcon: isIcon,
      isText: isText,
      icon: icon,
      text: text,
      type: type,
      isPadding: isPadding,
      paddingLeft: paddingLeft,
      paddingTop: paddingTop,
      paddingRight: paddingRight,
      paddingBottom: paddingBottom,
      isTextExpanded: isTextExpanded,
      fontSize: fontSize,
      iconSize: iconSize,
    ),
  );
}

btn(
    {VoidCallback? onPressed,
    Color backgroundColor = Colors.green,
    Color foregroundColor = Colors.white,
    isIcon = false,
    isText = false,
    IconData? icon,
    text,
    double fontSize = 20,
    double? iconSize,
    required type,
    isPadding = false,
    double? paddingLeft,
    double? paddingTop,
    double? paddingRight,
    double? paddingBottom,
    isTextExpanded = false}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: styleBtn(
      background: backgroundColor,
      foreground: foregroundColor,
      isPadding: isPadding,
      paddingLeft: paddingLeft,
      paddingTop: paddingTop,
      paddingRight: paddingRight,
      paddingBottom: paddingBottom,
    ),
    child: childBtn(
        isIcon: isIcon, isText: isText, icon: icon, text: text, fontSize: fontSize, iconSize: iconSize, type: type, isTextExpanded: isTextExpanded),
  );
}

pindahRespon(routename, argument, {isResult = false}) async {
  if (isResult) {
    var result = await Get.toNamed(routename, arguments: [argument]);
    return result;
  } else {
    await Get.toNamed(routename, arguments: [argument]);
  }
}

iconClick(routename, tipe, source, name, {argument}) {
  return InkWell(
    onTap: () async {
      pindahRespon(routename, argument);
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      decoration: iconBoxDecor(),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          IconButton(
            iconSize: getDevice() == 'tablet' ? 50 : 20,
            color: Colors.white,
            onPressed: () async {
              pindahRespon(routename, argument);
            },
            icon: tipe == 'image'
                ? Image.asset(
                    source,
                    height: getDevice() == 'tablet' ? 100 : 20,
                    width: getDevice() == 'tablet' ? 100 : 20,
                  )
                : Icon(source),
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: getDevice() == 'tablet' ? 30 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

portalClick(routename, tipe, source, {argument, visible = true}) {
  return Expanded(
    child: Visibility(
      visible: visible,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: iconBoxDecor(),
        child: Column(
          children: [
            IconButton(
              onPressed: () async {
                pindahRespon(routename, argument);
              },
              icon: tipe == 'image'
                  ? Image.asset(
                      source,
                      height: 100,
                      width: double.maxFinite,
                    )
                  : Icon(source),
            ),
          ],
        ),
      ),
    ),
  );
}

homeIcon({visible = true, double height = 125, required routename, required tipe, required source, required name, argument}) {
  return Visibility(
    visible: visible,
    child: SizedBox(
      height: height,
      child: iconClick(routename, tipe, source, name, argument: argument),
    ),
  );
}

dialogCustomBody(
    {required DialogType type, required Widget widget, Function(DismissType)? onDismissCallback, bool dismissOnTouchOutside = false, double? width}) {
  xdialog = AwesomeDialog(
    width: width,
    context: GlobalService.navigatorKey.currentState!.overlay!.context,
    animType: AnimType.scale,
    dialogType: type,
    keyboardAware: true,
    showCloseIcon: true,
    closeIcon: const Icon(FontAwesomeIcons.x),
    dismissOnTouchOutside: dismissOnTouchOutside,
    onDismissCallback: onDismissCallback,
    body: widget,
  )..show();
}
