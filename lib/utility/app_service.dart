import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppServicr {
  AppController appController = Get.put(AppController());

  Future<void> processregister({
    required String name,
    required String serName,
    required String phoneNumber,
    required String address,
    required String email,
    required String password,
    required String lat,
    required String lng,
  }) async {
    String urlApiCheckEmail =
        'https://www.androidthai.in.th/fluttertraining/few/getEmailWhereEmail.php?isAdd=true&email=$email';

    var resultCheckEmail = await Dio().get(urlApiCheckEmail);

    if (resultCheckEmail.toString() == 'null') {
      //ไม่ซ้ำ
    String customerId = 'cus-${Random().nextInt(1000)}';

    String urlAppRegister = 'https://www.androidthai.in.th/fluttertraining/few/insertUser.php?isAdd=true&customerId=$customerId&address=$address&customerName=$name&lastName=$serName&phoneNumber=$phoneNumber&lat=$lat&lng=$lng&email=$email&password=$password';


    await Dio().get(urlAppRegister).then((value) {
      Get.back();
      Get.snackbar('Register Success', 'Welcome to my App please Login');
    },);


    } else {
      Get.snackbar(
        'Email ซ้ำ',
        'มี $email ในฐานข้อมูลแล้วโปรดอัพเดตใหม่',
        backgroundColor: GFColors.DANGER,
        colorText: GFColors.WHITE,
      );
    }
  }

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
