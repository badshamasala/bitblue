import 'dart:convert';

import 'package:bitblueapp/app/modules/versionControll/models/version_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class VersionControllController extends GetxController {
  //TODO: Implement VersionControllController

  final count = 0.obs;
  @override
  void onInit() {
    getCurrentVersion();
    
    super.onInit();
  }



  Rx<bool> isLoading = false.obs;

  Rx<UrlandVersionModal?> getCurrentVersionData = UrlandVersionModal().obs;
  Rx<String?> version = Rx<String?>(null);
  Future<void> getCurrentVersion() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version.value = packageInfo.version;
      update();
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          "https://nodejs-api-production-9faa.up.railway.app/getUrlandVersion")); // I have host this api on a free server using railway.app

      if (response.statusCode == 200) {
        final jsonDecoded = jsonDecode(response.body);
        getCurrentVersionData.value = UrlandVersionModal.fromJson(jsonDecoded);
      } else {
        getCurrentVersionData.value = null;
      }
    } catch (exp) {
      if (kDebugMode) {
        print(exp);
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

}
