import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controllers/version_controll_controller.dart';
import 'package:ota_update/ota_update.dart';

class VersionControllView extends GetView<VersionControllController> {
  const VersionControllView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VersionControllView',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              
              style: TextButton.styleFrom(
                alignment: Alignment.center,
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: () {
                if (kDebugMode) {
                  print(
                      "Api-Version---------------${controller.getCurrentVersionData.value?.latestVersion}\nCurrent Version-----------------${controller.version.value}");
                }
                      
                if (controller.getCurrentVersionData.value?.latestVersion !=
                    controller.version.value) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Version Update Required'),
                        content: const Text(
                            'Your version is not up to date. Please update to the latest version.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Update'),
                            onPressed: () {
                              // Implement update logic or redirect to update page
                              // IMPORT PACKAGE
                      
                              // RUN OTA UPDATE
                              // START LISTENING FOR DOWNLOAD PROGRESS REPORTING EVENTS
                              try {
                                //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
                                OtaUpdate()
                                    .execute(
                                  "${controller.getCurrentVersionData.value?.url}",
                                  // OPTIONAL
                                  destinationFilename: 'bitblue.apk',
                                  //OPTIONAL, ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
                                 
                                )
                                    .listen(
                                  (OtaEvent event) {
                                    // setState(() => currentEvent = event);
                                  },
                                );
                              } catch (e) {
                                if (kDebugMode) {
                                  print('Failed to make OTA update. Details: $e');
                                }
                              }
                            },
                          ),
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text("Check Current Version"),
            ),
          ),
          Obx(() =>  Text(controller.version.value ?? "",style: TextStyle(color: Colors.black),))
        ],
      ),
    );
  }
}
