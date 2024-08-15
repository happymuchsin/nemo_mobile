// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nemo/app/routes/routes.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class ViewAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ViewAppBar({super.key, title, halaman})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        judul = title,
        page = halaman;

  @override
  State<ViewAppBar> createState() => _ViewAppBarState();

  @override
  final Size preferredSize;
  final String judul;
  final String page;
}

class _ViewAppBarState extends State<ViewAppBar> {
  String? area, lokasi, judul, mode, name, username;
  final localShared = LocalShared();
  final apiReq = Api();
  String? deviceType;

  @override
  void initState() {
    super.initState();
    awalan();
  }

  void awalan() async {
    setState(() {
      deviceType = getDevice();
    });
    await header();
  }

  Future<void> header() async {
    var _mode = await localShared.baca('mode');
    var _name = await localShared.baca('name');
    var _username = await localShared.baca('username');
    var _area = await localShared.baca('area');
    var _lokasi = await localShared.baca('lokasi');
    setState(() {
      mode = _mode;
      name = _name;
      username = _username;
      area = _area;
      lokasi = _lokasi;
    });
  }

  Future<void> alert() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      showCloseIcon: false,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: 'Attention',
      desc: 'Are you sure want to Log out?',
      btnCancelText: 'No',
      btnCancelOnPress: () {},
      btnOkText: 'Yes',
      btnOkOnPress: () {
        logout();
      },
    ).show();
  }

  Future<void> logout() async {
    await localShared.hapusSemua();
    Get.offAllNamed(Routes.login);
    // var a = await apiReq.baseUrl();
    // var r = await apiReq.makeRequest("$a/user/logout", '');
    // if (r['success'] == 200) {
    //   await localShared.hapusSemua();
    //   Get.offAllNamed(Routes.login);
    // } else {
    //   EasyLoading.dismiss();
    //   notif(r['message']);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF2A6689),
      foregroundColor: Colors.white,
      toolbarHeight: kToolbarHeight,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width * .2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.judul.toString(),
                  style: TextStyle(fontSize: deviceType == 'tablet' ? 30 : 18),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width * .3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (kReleaseMode) Image.asset('assets/img/anggun.png')
                // Text(
                //   area.toString(),
                //   style: TextStyle(fontSize: deviceType == 'tablet' ? 30 : 18),
                // ),
                // Text(
                //   lokasi.toString(),
                //   style: TextStyle(fontSize: deviceType == 'tablet' ? 30 : 18),
                // ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width * .2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text(mode != 'live' ? "${mode.toString().toUpperCase()} ${name.toString()}" : name.toString()),
                Text(
                  name.toString(),
                  style: TextStyle(fontSize: deviceType == 'tablet' ? 30 : 18),
                ),
                Text(
                  username.toString(),
                  style: TextStyle(fontSize: deviceType == 'tablet' ? 30 : 18),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          onSelected: (value) {
            switch (value) {
              case "logout":
                alert();
                break;
              case "update":
                apiReq.alert('appbar');
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            if (widget.page == 'dashboard')
              const PopupMenuItem(
                value: "update",
                child: Text('Check Update'),
              ),
            const PopupMenuItem(
              value: "logout",
              child: Text('Log out'),
            ),
          ],
        ),
      ],
    );
  }
}
