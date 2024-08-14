import 'package:get/get.dart';

import '../controllers/version_controll_controller.dart';

class VersionControllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VersionControllController>(
      () => VersionControllController(),
    );
  }
}
