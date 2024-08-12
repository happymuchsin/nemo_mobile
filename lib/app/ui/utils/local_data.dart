import 'package:shared_preferences/shared_preferences.dart';

class LocalShared {
  Future<void> simpan(key, value, {type}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (type == 'list') {
      preferences.setStringList(key, value);
    } else if (type == 'int') {
      preferences.setInt(key, value);
    } else {
      preferences.setString(key, value);
    }
  }

  Future<void> hapus(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  Future<void> hapusSemua() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Future<String?> baca(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<List<String>?> bacaList(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key);
  }

  Future<int?> bacaInt(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key);
  }
}
