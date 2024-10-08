import 'package:get/get.dart';
import 'package:nemo/app/bindings/approval_binding.dart';
import 'package:nemo/app/bindings/change_needle_binding.dart';
import 'package:nemo/app/bindings/login_binding.dart';
import 'package:nemo/app/bindings/needle_stock_binding.dart';
import 'package:nemo/app/bindings/portal_binding.dart';
import 'package:nemo/app/bindings/request_new_needle_binding.dart';
import 'package:nemo/app/ui/pages/approval_page/approval_page.dart';
import 'package:nemo/app/ui/pages/change_needle_page/change_needle_page.dart';
import 'package:nemo/app/ui/pages/login_page/login_page.dart';
import 'package:nemo/app/ui/pages/needle_stock_page/needle_stock_page.dart';
import 'package:nemo/app/ui/pages/portal_page/portal_page.dart';
import 'package:nemo/app/ui/pages/request_new_needle_page/request_new_needle_page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.login, page: () => const LoginPage(), binding: LoginBinding()),
    GetPage(name: Routes.portal, page: () => const PortalPage(), binding: PortalBinding()),
    GetPage(name: Routes.changeNeedle, page: () => const ChangeNeedlePage(), binding: ChangeNeedleBinding()),
    GetPage(name: Routes.approval, page: () => const ApprovalPage(), binding: ApprovalBinding()),
    GetPage(name: Routes.requestNewNeedle, page: () => const RequestNewNeedlePage(), binding: RequestNewNeedleBinding()),
    GetPage(name: Routes.needleStock, page: () => const NeedleStockPage(), binding: NeedleStockBinding()),
  ];
}

abstract class Routes {
  static const portal = '/portal';
  static const login = '/login';

  static const changeNeedle = '/change-needle';
  static const approval = '/approval';
  static const requestNewNeedle = '/request-new-needle';
  static const needleStock = '/needle-stock';
}
