import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:easy_app_installer/easy_app_installer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/routes/routes.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/local_data.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

class Api extends GetxController {
  final localShared = LocalShared();
  final dio = Dio();
  final CancelToken cancelToken = CancelToken();

  List<String> liveEndpoints = [
    'http://192.168.40.185/nemo/public/api/testcon',
  ];

  List<String> localEndpoints = [
    'http://192.168.150.72/api/testcon', // local lan
  ];

  Future<String?> baseUrl() async {
    String? mode = await localShared.baca('mode');
    var a = await testApi(mode);
    if (a == 'berhasil') {
      var base = await localShared.baca('base');
      return base;
    } else {
      return 'Connection Error';
    }
  }

  Future<String> testApi(mode) async {
    var end = [];
    if (mode == 'live') {
      end = liveEndpoints;
    } else if (mode == 'local') {
      end = localEndpoints;
    }
    for (String endpoint in end) {
      try {
        var a = await makeRequest(endpoint, {});
        if (a['success'] == 200) {
          if (a['message'] == 'connect') {
            var base = endpoint.replaceAll('/testcon', '');
            var baseUrl = '';
            if (mode == 'local') {
              baseUrl = base.replaceAll('/api', '');
            } else {
              baseUrl = base.replaceAll('/nemo/public/api', '');
            }
            localShared.simpan('base', base);
            localShared.simpan('baseUrl', baseUrl);
            return 'berhasil';
          }
        }
      } catch (_) {}
    }

    return 'gagal';
  }

  Future<void> alert(from) async {
    try {
      EasyLoading.show(status: 'Checking Update');
      Map<String, dynamic> data = {};
      data['app'] = 'nemo';
      var a = await baseUrl();
      final response = await dio.post(
        "$a/version",
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.data['success'] == 200) {
        String lastVersion = response.data['data']['version'].toString();
        String lastRemark = response.data['data']['remark'].toString();

        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        Version now = Version.parse(packageInfo.version);
        Version last = Version.parse(lastVersion);

        bool? status;
        if (last > now) {
          status = true;
        } else {
          status = false;
        }
        EasyLoading.dismiss();
        if (from == 'portal') {
          if (status == true) {
            EasyAppInstaller.instance.downloadAndInstallApk(
                fileUrl: "$a/update?app=nemo&version=${last.toString()}",
                fileDirectory: "updateApk",
                fileName: "nemo${last.toString()}.apk",
                onDownloadingListener: (progress) {
                  if (progress < 100) {
                    EasyLoading.showProgress(progress / 100, status: "Downloading ...");
                  } else {
                    EasyLoading.showSuccess("Installing ...");
                  }
                });
          }
        } else {
          dialogCustomBody(
            type: DialogType.info,
            widget: Column(
              children: [
                const Text(
                  'Attention',
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  status == true ? "Update Available" : "No Update Available",
                  style: const TextStyle(fontSize: 20),
                ),
                status == true
                    ? Text(
                        lastRemark,
                        style: const TextStyle(fontSize: 20),
                      )
                    : Container(),
                status == true
                    ? ElevatedButton(
                        onPressed: () {
                          xdialog.dismiss();
                          EasyAppInstaller.instance.downloadAndInstallApk(
                              fileUrl: "$a/update?app=nemo&version=${last.toString()}",
                              fileDirectory: "updateApk",
                              fileName: "nemo${last.toString()}.apk",
                              onDownloadingListener: (progress) {
                                if (progress < 100) {
                                  EasyLoading.showProgress(progress / 100, status: "Downloading ...");
                                } else {
                                  EasyLoading.showSuccess("Installing ...");
                                }
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.system_update_alt),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Update Now'),
                          ],
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          xdialog.dismiss();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.check),
                            SizedBox(
                              width: 10,
                            ),
                            Text('OK'),
                          ],
                        ),
                      )
              ],
            ),
          );
        }
      } else {
        EasyLoading.dismiss();
        notif(response.data['message']);
      }
    } catch (e) {
      EasyLoading.dismiss();
      notif(e.toString());
    }
  }

  Future<void> login(data) async {
    try {
      var a = await baseUrl();
      final response = await dio.post(
        "$a/login",
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
      if (response.data['success'] == 200) {
        localShared.simpan('token', response.data['data']['token']);
        localShared.simpan('id', response.data['data']['user']['id'], type: 'int');
        localShared.simpan('username', response.data['data']['user']['username']);
        localShared.simpan('name', response.data['data']['user']['name']);
        localShared.simpan('division', response.data['data']['user']['division']['name']);
        localShared.simpan('division_id', response.data['data']['user']['division']['id'], type: 'int');
        localShared.simpan('position', response.data['data']['user']['position']['name']);
        localShared.simpan('position_id', response.data['data']['user']['position']['id'], type: 'int');
        localShared.simpan('reff', response.data['data']['reff']);
        localShared.simpan('area', response.data['data']['area']);
        localShared.simpan('area_id', response.data['data']['area_id'], type: 'int');
        localShared.simpan('lokasi', response.data['data']['lokasi']);
        localShared.simpan('lokasi_id', response.data['data']['lokasi_id'], type: 'int');
        var roleList = List<String>.from(response.data['data']['role'] as List);
        localShared.simpan('role', roleList, type: 'list');
        EasyLoading.dismiss();
        Get.offAllNamed(Routes.portal);
      } else {
        EasyLoading.dismiss();
        notif(response.data['message']);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        EasyLoading.dismiss();
        notif('Connection timeout');
      }
      EasyLoading.dismiss();
      notif(e.toString());
    }
  }

  Future<Map> makeRequest(url, data, {int second = 10}) async {
    Map<String, dynamic> balikan = {};
    try {
      var token = await localShared.baca('token');
      dio.options.connectTimeout = Duration(seconds: second);
      dio.options.receiveTimeout = Duration(seconds: second);
      Options? options = Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        sendTimeout: Duration(seconds: second),
        receiveTimeout: Duration(seconds: second),
      );
      final response = await dio.post(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      balikan['success'] = response.data['success'];
      balikan['message'] = response.data['message'];
      balikan['data'] = response.data['data'];
      return balikan;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        balikan['success'] = 422;
        balikan['message'] = 'Connection Timeout';
        balikan['data'] = '';
        return balikan;
      }

      if (e.type == DioExceptionType.cancel) {
        balikan['success'] = 423;
        balikan['message'] = e.toString();
        balikan['data'] = '';
        return balikan;
      }

      balikan['success'] = 422;
      balikan['message'] = e.toString();
      balikan['data'] = '';
      return balikan;
    } catch (e) {
      balikan['success'] = 422;
      balikan['message'] = e.toString();
      balikan['data'] = '';
      return balikan;
    }
  }
}
