import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/user_model.dart';

import 'package:testdb/screens/main_home.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppServicr {
  AppController appController = Get.put(AppController());
  Future<void> readAllOrder() async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/few/getAllOrder.php';
    var result = await Dio().get(urlApi);

    if (appController.orderWashModels.isNotEmpty) {
      appController.orderWashModels.clear();
    }

    for (var element in json.decode(result.data)) {
      OrderWashModel model = OrderWashModel.fromMap(element);

      if (model.customerId == appController.currentUserModels.last.customerId) {
        appController.orderWashModels.add(model);
      }
    }
  }

  Future<void> processInsertOrder(
      {required OrderWashModel orderWashModel}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/few/insertOrder.php?isAdd=true&refWash=${orderWashModel.refWash}&customerId=${orderWashModel.customerId}&dateStart=${orderWashModel.dateStart}&timeStart=${orderWashModel.timeStart}&dateEnd=${orderWashModel.dateEnd}&timeEnd=${orderWashModel.timeEnd}&dry=${orderWashModel.dry}&amountCloth=${orderWashModel.amountCloth}&detergen=${orderWashModel.detergen}&softener=${orderWashModel.softener}&total=${orderWashModel.total}&status=${orderWashModel.status}';

    await Dio().get(urlApi).then((value) async {
      await Get.deleteAll().then((value) {
        findCuttentUserLogin();

        Get.back();
        Get.snackbar('Oeder Success', 'thank order');
      });
    });
  }

  Future<void> findCuttentUserLogin() async {
    var result = await GetStorage().read('data');

    if (result != null) {
      String urlAPI =
          'https://www.androidthai.in.th/fluttertraining/few/getEmailWhereEmail.php?isAdd=true&email=${result["email"]}';

      var response = await Dio().get(urlAPI);

      for (var element in json.decode(response.data)) {
        UserModel model = UserModel.fromMap(element);
        appController.currentUserModels.add(model);
      }
    }
  }

  String changDateTimeToString(
      {required DateTime dateTime, String? timeFormat}) {
    DateFormat dateFormat = DateFormat(timeFormat ?? 'dd / MMM / yy');
    String result = dateFormat.format(dateTime);

    return result;
  }

  Future<void> processCheckLogin({
    required String email,
    required String password,
  }) async {
    String urlApiCheckLogin =
        'https://www.androidthai.in.th/fluttertraining/few/getEmailWhereEmail.php?isAdd=true&email=$email';

    await Dio().get(urlApiCheckLogin).then(
      (value) async {
        if (value.toString() == 'null') {
          Get.snackbar('Email False', 'NO $email ในฐานข้อมูล',
              backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
        } else {}
        for (var element in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(element);

          if (model.password == password) {
            //password true

            await GetStorage().write('data', model.toMap()).then((value) {
              Get.offAll(const MainHome());
            });
          } else {
            Get.snackbar('Password false', 'Please Tye Again Passsword',
                backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
          }
        }
      },
    );
  }

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

      String urlAppRegister =
          'https://www.androidthai.in.th/fluttertraining/few/insertUser.php?isAdd=true&customerId=$customerId&address=$address&customerName=$name&lastName=$serName&phoneNumber=$phoneNumber&lat=$lat&lng=$lng&email=$email&password=$password';

      await Dio().get(urlAppRegister).then(
        (value) {
          Get.back();
          Get.snackbar('Register Success', 'Welcome to my App please Login');
        },
      );
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
    print('locationService  ---> $locationService');

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
