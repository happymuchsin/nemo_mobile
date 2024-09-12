// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/utils/global_context.dart';

headerFile(
  text, {
  double fontSize = 20,
  double paddingLeft = 10,
  double paddingTop = 10,
  double paddingRight = 10,
  double paddingBottom = 10,
  axis = MainAxisAlignment.start,
}) {
  return Container(
    margin: EdgeInsets.fromLTRB(paddingLeft, paddingTop, paddingRight, paddingBottom),
    child: Row(
      mainAxisAlignment: axis,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    ),
  );
}

boxThumbImage(path, {double h = 50, double w = 50}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: thumbImage(path, h: h, w: w),
  );
}

addNewImage(status, {isAsset = false, asset}) {
  return Container(
    decoration: BoxDecoration(
      image: isAsset ? DecorationImage(image: AssetImage(asset), fit: BoxFit.fill) : null,
      color: status ? Colors.red : Colors.grey[300],
    ),
    width: double.maxFinite,
    height: double.maxFinite,
    child: const Icon(FontAwesomeIcons.plus),
  );
}

thumbImage(path, {double h = 50, double w = 50}) {
  return Image.file(
    File(path),
    height: h,
    width: w,
    fit: BoxFit.contain,
  );
}

inputForm(
  read,
  lines,
  controller,
  text, {
  double left = 10,
  double top = 10,
  double right = 10,
  double bottom = 10,
  double labelFontSize = 0,
  double fontSize = 0,
  isCollapsed = false,
  isValidator = false,
  isSuffix = false,
  suffixText,
  isSuffixIcon = false,
  suffixIcon,
  isPrefix = false,
  prefixText,
  isPrefixIcon = false,
  prefixIcon,
  isHintText = false,
  hintText,
  date = 'no',
  time = 'no',
  range = 'no',
  kode = 'not',
  enable = true,
  isAlign = false,
  isFloatingAlign = false,
  floatingAlign,
  textAlign,
  isChange = false,
  isTap = false,
  FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.auto,
  ValueChanged<String?>? onchanged,
  VoidCallback? onTap,
  Color warna = Colors.black,
  TextInputType inputType = TextInputType.text,
  inputFormatter,
  customRange = 'no',
  customStart,
  customEnd,
  hasFocusedBorder = false,
  focusNode,
}) {
  if (labelFontSize == 0) {
    if (getDevice() == 'tablet') {
      labelFontSize = 30;
    } else {
      labelFontSize = 18;
    }
  }

  if (fontSize == 0) {
    if (getDevice() == 'tablet') {
      fontSize = 20;
    } else {
      fontSize = 12;
    }
  }
  return Container(
    margin: EdgeInsets.fromLTRB(left, top, right, bottom),
    child: TextFormField(
      focusNode: focusNode,
      onChanged: isChange ? onchanged : null,
      inputFormatters: inputFormatter,
      keyboardType: inputType,
      enabled: enable,
      readOnly: read,
      maxLines: lines,
      controller: controller,
      onTap: !isTap
          ? () async {
              if (date == 'yes') {
                DateTime? pickedDate = await showDatePicker(
                  barrierDismissible: false,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  context: GlobalService.navigatorKey.currentState!.overlay!.context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 5), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(DateTime.now().year + 5),
                );

                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  controller.text = formattedDate;
                }
              }

              if (time == 'yes') {
                TimeOfDay? pickedTime = await showTimePicker(
                  barrierDismissible: false,
                  initialEntryMode: TimePickerEntryMode.dial,
                  context: GlobalService.navigatorKey.currentState!.overlay!.context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  controller.text = "${pickedTime.hour}:${pickedTime.minute}";
                }
              }

              if (range == 'yes') {
                DateTime start = DateTime.now();
                if (kode == 'C' || kode == 'CT') {
                  start = DateTime.now().add(const Duration(days: 7));
                }
                DateTimeRange? pickedDate = await showDateRangePicker(
                  barrierDismissible: false,
                  context: GlobalService.navigatorKey.currentState!.overlay!.context,
                  initialDateRange: DateTimeRange(start: start, end: start),
                  firstDate: start,
                  lastDate: DateTime(DateTime.now().year + 5),
                );

                if (pickedDate != null) {
                  String formattedDateStart = DateFormat('yyyy-MM-dd').format(pickedDate.start);
                  String formattedDateEnd = DateFormat('yyyy-MM-dd').format(pickedDate.end);
                  controller.text = "$formattedDateStart - $formattedDateEnd";
                }
              }

              if (customRange == 'yes') {
                DateTimeRange? pickedDate = await showDateRangePicker(
                  barrierDismissible: false,
                  context: GlobalService.navigatorKey.currentState!.overlay!.context,
                  initialDateRange: DateTimeRange(start: customStart, end: customEnd),
                  firstDate: customStart,
                  lastDate: customEnd,
                );

                if (pickedDate != null) {
                  String formattedDateStart = DateFormat('yyyy-MM-dd').format(pickedDate.start);
                  String formattedDateEnd = DateFormat('yyyy-MM-dd').format(pickedDate.end);
                  controller.text = "$formattedDateStart - $formattedDateEnd";
                }
              }
            }
          : onTap,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        floatingLabelBehavior: floatingLabelBehavior,
        floatingLabelAlignment: isFloatingAlign ? floatingAlign : FloatingLabelAlignment.start,
        labelText: text,
        labelStyle: TextStyle(fontSize: labelFontSize, color: warna),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: isValidator ? const Color(0xFFFF0000) : const Color(0xFF000000))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: isValidator ? const Color(0xFFFF0000) : const Color(0xFF000000))),
        suffixText: isSuffix ? suffixText : null,
        suffixIcon: isSuffixIcon ? suffixIcon : null,
        prefixText: isPrefix ? prefixText : null,
        prefixIcon: isPrefixIcon ? prefixIcon : null,
        hintText: isHintText ? hintText : null,
        focusedBorder: hasFocusedBorder
            ? OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(width: 5, color: Colors.green))
            : null,
      ),
      style: TextStyle(fontSize: fontSize, color: warna),
      textAlign: isAlign ? textAlign : TextAlign.start,
    ),
  );
}

menuForm({required List<Widget> isi}) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      children: isi,
    ),
  );
}

fixedForm(kiri, kanan, {type = 2, kiri2, kanan2, double fontSize = 18}) {
  if (type == 2) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              kiri,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              kanan,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  } else if (type == 4) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              kiri,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              kanan,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              kiri2,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              kanan2,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
