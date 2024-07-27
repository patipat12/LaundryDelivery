import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppServicr {
  AppController appController = Get.put(AppController());

  Future<void> processFinPosition() async {
    bool locationService = await Geolocator.isLocationServiceEnabled();
    print('locationService  ==> $locationService');

    if (locationService) {
      //open Service

      LocationPermission locationPermission =
          await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        //deniedForever

        dialogCallPermissionlocation();
      } else {

        //Away,whileInUser,Denied

        if (locationPermission == LocationPermission.denied) {
          //denied

          locationPermission = await Geolocator.requestPermission();

          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {

                dialogCallPermissionlocation();



                
          } else {
              Position position = await Geolocator.getCurrentPosition();
          appController.positions.add(position);

          }
        } else {
          Position position = await Geolocator.getCurrentPosition();
          appController.positions.add(position);
        }
      }
    } else {
      //off Service
      AppDialog().normalDialog(
          title: 'โปรดเปิดโลเคชั่น',
          seconAction: WidgetButton(
              onPressed: () async {
                await Geolocator.openLocationSettings()
                    .then((value) => exit(0));
              },
              text: 'เปิดโลเคชันเซอวิส'));
    }
  }

  void dialogCallPermissionlocation() {
    AppDialog().normalDialog(
        title: 'โปรดอนุญาติแชร์พิกัด',
        seconAction: WidgetButton(
            onPressed: () async {
              await Geolocator.openLocationSettings().then(
                (value) => exit(0),
              );
            },
            text: 'โปรดอนุญาติแชร์พิกัด'));
  }
}
