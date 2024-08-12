import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nemo/app/data/services/notification_services.dart';
import 'package:nemo/app/data/services/socket_service.dart';
import 'package:nemo/app/routes/routes.dart';
import 'package:nemo/app/ui/utils/global_context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  Get.put(SocketService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GetMaterialApp(
      navigatorKey: GlobalService.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.portal,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      builder: EasyLoading.init(),
    );
  }
}
