import 'package:get/get.dart';
import 'package:nemo/app/data/services/notification_services.dart';
import 'package:nemo/app/ui/utils/local_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as io_master;

class SocketService extends GetxService {
  io_master.Socket? socket;
  var baseUrl = "".obs, username = "".obs;
  var division = 0.obs, position = 0.obs;
  final localShared = LocalShared();

  @override
  void onInit() {
    super.onInit();
    connect();
  }

  void connect() async {
    username(await localShared.baca('username'));
    division(await localShared.bacaInt('division_id'));
    position(await localShared.bacaInt('position_id'));
    baseUrl(await localShared.baca('baseUrl'));
    // print('connect socket');
    // print('${username.value} - ${depart.value} - ${baseUrl.value}');
    if (baseUrl.value != "") {
      if (socket != null && socket!.connected) {
        socket!.disconnect();
        socket!.dispose();
        socket!.close();
      }

      socket = io_master.io('${baseUrl.value}:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket!.connect();
      // socket!.onConnecting((err) => print(err));
      // socket!.onConnectError((err) => print(err));
      // socket!.onConnectTimeout((err) => print(err));
      socket!.onConnect((_) async {
        // print('socket connected');
        Map<String, dynamic> data = {};
        data['username'] = username.value;
        data['division'] = division.value;
        data['position'] = position.value;
        data['type'] = 'mobile';
        data['app'] = 'nemo';

        socket!.emit('register', data); // ganti iniuuid dengan username
      });
      // socket.onDisconnect((_) => print('Connection Disconnection'));
      // socket!.onError((err) => print(err));
      // socket.on('reloadNotif', (data) {
      //   _handleMessage(data);
      // });
      socket!.on('notif', (data) {
        // print(data);
        _handleMessage(title: data['title'], message: data['message']);
      });
    }
  }

  void _handleMessage({title, message}) {
    // Handle the incoming message and show a notification
    NotificationService().showNotification(
      0,
      title,
      message,
    );
  }

  void disconnectSocket() async {
    if (socket != null && socket!.connected) {
      socket!.disconnect();
      socket!.dispose();
      socket!.close();
      socket = null;
    }
  }

  @override
  void onClose() {
    socket!.disconnect();
    socket!.dispose();
    super.onClose();
  }
}
