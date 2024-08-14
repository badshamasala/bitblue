import 'package:get/get.dart';

import '../modules/versionControll/bindings/version_controll_binding.dart';
import '../modules/versionControll/views/version_controll_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.versionControl;

  static final routes = [
    GetPage(
      name: _Paths.versionControl,
      page: () => const VersionControllView(),
      binding: VersionControllBinding(),
    ),
  ];
}
