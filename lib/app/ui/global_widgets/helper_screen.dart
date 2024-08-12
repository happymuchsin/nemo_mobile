import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

String getInitials(String input) {
  if (input.contains(' ')) {
    List<String> words = input.split(' ');
    String firstInitial = words.first[0];
    String lastInitial = words.last[0];
    return firstInitial.toUpperCase() + lastInitial.toUpperCase();
  } else {
    return input[0].toUpperCase();
  }
}

String getDevice() {
  if (Get.size.shortestSide > 600) {
    return 'tablet';
  } else {
    return 'hp';
  }
}

Future<String> saveFileTo(List<int> fileBytes, name, type) async {
  String dir = "";
  if (type == 'cache') {
    dir = (await getTemporaryDirectory()).path;
  } else if (type == 'storage') {
    dir = (await getApplicationDocumentsDirectory()).path;
  } else if (type == 'download') {
    if (Platform.isAndroid) {
      dir = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
  }
  final File file = File('$dir/$name');
  await file.writeAsBytes(fileBytes);
  return file.path;
}

Future<Map<String, dynamic>> searchFile(name, type) async {
  Map<String, dynamic> balikan = {};
  String dir = "";
  if (type == 'cache') {
    dir = (await getTemporaryDirectory()).path;
  } else if (type == 'storage') {
    dir = (await getApplicationDocumentsDirectory()).path;
  } else if (type == 'download') {
    if (Platform.isAndroid) {
      dir = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
  }
  final File file = File('$dir/$name');
  if (await file.exists()) {
    balikan['found'] = 'yes';
    balikan['path'] = file.path;
    return balikan;
  } else {
    balikan['found'] = 'not';
    return balikan;
  }
}

Future<void> deleteFile(name, type) async {
  String dir = "";
  if (type == 'cache') {
    dir = (await getTemporaryDirectory()).path;
  } else if (type == 'storage') {
    dir = (await getApplicationDocumentsDirectory()).path;
  } else if (type == 'download') {
    if (Platform.isAndroid) {
      dir = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
  }
  final File file = File('$dir/$name');
  if (await file.exists()) {
    file.delete();
  }
}

Future<List<Uint8List>> getXFilesAsUint8ListList(List<XFile> xFileList) async {
  List<Uint8List> uint8ListList = [];

  for (var xFile in xFileList) {
    Uint8List uint8List = await getXFileAsUint8List(xFile);
    uint8ListList.add(uint8List);
  }

  return uint8ListList;
}

Future<Uint8List> getXFileAsUint8List(XFile xFile) async {
  // Baca file sebagai byte
  final File file = File(xFile.path);
  List<int> bytes = await file.readAsBytes();

  // Konversi List<int> menjadi Uint8List
  Uint8List uint8List = Uint8List.fromList(bytes);

  return uint8List;
}

Future<List<XFile>> convertUint8ListToXFileList(List<Uint8List> uint8ListList) async {
  List<XFile> xFileList = [];

  for (var uint8List in uint8ListList) {
    final xFile = await convertUint8ListToXFile(uint8List);
    xFileList.add(xFile);
  }

  return xFileList;
}

Future<XFile> convertUint8ListToXFile(Uint8List uint8List) async {
  // Dapatkan direktori penyimpanan sementara
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // Buat file baru di direktori sementara
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  File tempFile = File('$tempPath/image_$timestamp.png');

  // Tulis data Uint8List ke file
  await tempFile.writeAsBytes(uint8List);

  // Buat XFile dari file yang disimpan
  XFile xFile = XFile(tempFile.path);

  return xFile;
}
