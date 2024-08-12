import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';

InputDecoration wxInputDecoration({required text, double labelFontSize = 0, isValidator = false}) {
  if (labelFontSize == 0) {
    if (getDevice() == 'tablet') {
      labelFontSize = 30;
    } else {
      labelFontSize = 18;
    }
  }
  return InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    labelText: text,
    labelStyle: TextStyle(fontSize: labelFontSize),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1, color: isValidator ? const Color(0xFFFF0000) : const Color(0xFF000000))),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1, color: isValidator ? const Color(0xFFFF0000) : const Color(0xFF000000))),
  );
}

DropdownSearchData<String> wxDropdownSearchData({required controller}) {
  return DropdownSearchData(
    searchController: controller,
    searchInnerWidgetHeight: 50,
    searchInnerWidget: Container(
      height: 50,
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 4,
        right: 8,
        left: 8,
      ),
      child: TextFormField(
        // textCapitalization: TextCapitalization.characters,
        expands: true,
        maxLines: null,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          hintText: 'Search for an item...',
          hintStyle: const TextStyle(fontSize: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    searchMatchFn: (item, searchValue) {
      return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
    },
  );
}

ButtonStyle styleBtn(
    {background, foreground, isPadding = false, double? paddingLeft, double? paddingRight, double? paddingTop, double? paddingBottom}) {
  return ElevatedButton.styleFrom(
    padding: isPadding ? EdgeInsets.fromLTRB(paddingLeft!, paddingTop!, paddingRight!, paddingBottom!) : null,
    foregroundColor: foreground,
    backgroundColor: background,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

childBtn({isIcon = false, isText = false, icon, text, double fontSize = 20, double? iconSize, type, isTextExpanded = false}) {
  if (type == 'column') {
    return Column(
      children: [
        isIcon ? Icon(icon) : const SizedBox(),
        isText && isIcon
            ? const SizedBox(
                width: 15,
              )
            : const SizedBox(),
        isText
            ? Text(
                text,
                style: TextStyle(fontSize: fontSize),
              )
            : const SizedBox(),
      ],
    );
  } else if (type == 'row') {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isIcon
            ? Icon(
                icon,
                size: iconSize,
              )
            : const SizedBox(),
        isText && isIcon
            ? const SizedBox(
                width: 15,
              )
            : const SizedBox(),
        isText
            ? isTextExpanded
                ? Expanded(
                    child: Text(
                      text,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(fontSize: fontSize),
                  )
            : const SizedBox(),
      ],
    );
  }
}

titlePage({title, double? fontSize, fontWeight = FontWeight.bold, Color? color}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

showImage({from, img, double? height, double? width}) {
  if (from == 'asset') {
    return Image.asset(
      img,
      height: height,
      width: width,
    );
  }
}

modalTitle({required text, double fontSize = 30, fontWeight = FontWeight.bold, color}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
  );
}

BoxDecoration iconBoxDecor() {
  return BoxDecoration(
    // color: Colors.white,
    color: const Color(0xFF50BFFF),
    borderRadius: BorderRadius.circular(5),
    // boxShadow: [
    //   BoxShadow(
    //     color: const Color.fromRGBO(239, 91, 36, 1).withOpacity(0.6),
    //     spreadRadius: 2,
    //     blurRadius: 7,
    //     offset: const Offset(6, 6), // changes position of shadow
    //   ),
    // ],
  );
}

jam() {
  return StreamBuilder(
    stream: Stream.periodic(const Duration(seconds: 1)),
    builder: (context, snapshot) {
      return Text(
        DateFormat('dd MMMM yyyy HH:mm:ss').format(DateTime.now()),
        style: const TextStyle(fontSize: 20, color: Colors.purple),
      );
    },
  );
}
