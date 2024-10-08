import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:testdb/models/message_model.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/user_model.dart';
import 'package:testdb/screens/admin_page.dart';
import 'package:testdb/screens/main_home.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/widgets/widget_button.dart';

class AppServicr {
  AppController appController = Get.put(AppController());

  Future<void> processReadAllmessageCustomer() async {
    if (appController.customerChatUserModels.isNotEmpty) {
      appController.customerChatUserModels.clear();
    }

    var result = await FirebaseFirestore.instance.collection('customer').get();

    if (result.docs.isNotEmpty) {
      for (var element in result.docs) {
        UserModel model = UserModel.fromMap(element.data());
        appController.customerChatUserModels.add(model);
      }
    }
  }

  Future<void> readAllMessageCustomerIdUser(
      {required String customerIdUser}) async {
    await FirebaseFirestore.instance
        .collection('customer')
        .doc(customerIdUser)
        .collection('message')
        .orderBy('timestame')
        .snapshots()
        .listen((event) {
      if (appController.messageModels.isNotEmpty) {
        appController.messageModels.clear();
      }

      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          MessageModel model = MessageModel.fromMap(element.data());
          appController.messageModels.add(model);
        }
      }
    });
  }

  Future<void> processCheckHaveCustomer() async {
    var result = await FirebaseFirestore.instance
        .collection('customer')
        .doc(appController.currentUserModels.last.customerId)
        .get();

    if (result.data() == null) {
      await FirebaseFirestore.instance
          .collection('customer')
          .doc(appController.currentUserModels.last.customerId)
          .set(appController.currentUserModels.last.toMap());
    }
  }

  Future<void> processSendMessage(
      {required MessageModel messageModel, String? customerId}) async {
    await FirebaseFirestore.instance
        .collection('customer')
        .doc( customerId ??  messageModel.customerId)
        .collection('message')
        .doc()
        .set(messageModel.toMap());
  }

  int calculateTotal({required List<OrderWashModel> orderWashModels}) {
    int total = 0;
    for (var element in orderWashModels) {
      total = total + int.parse(element.total.trim());
    }
    return total;
  }

  Future<List<OrderWashModel>> processReadOrderWhereStatus(
      {required String status}) async {
    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/few/getOrderWhereStatus.php?isAdd=true&status=$status';

    var orderWashModels = <OrderWashModel>[];

    var result = await Dio().get(urlAPI);

    if (result.toString() != 'null') {
      for (var element in json.decode(result.data)) {
        OrderWashModel model = OrderWashModel.fromMap(element);
        orderWashModels.add(model);
      }
    }

    return orderWashModels;
  }

  Future<void> processEditStatusByIdOrder({
    required String id,
    required String Status,
    String? idAdminReceive,
    String? idAdminOrder,
  }) async {
    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/few/editStatusWhereId.php?isAdd=true&id=$id&status=$Status&idAdminReceive=$idAdminReceive&idAdminOrder=$idAdminOrder';

    await Dio().get(urlAPI).then((value) {
      Get.back();
    });
  }

  Future<UserModel?> findUserModelFromCustomerId(
      {required String customerId}) async {
    UserModel? usermodel;

    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/few/getUserWhereCustomerId.php?isAdd=true&customerId=$customerId';

    var result = await Dio().get(urlApi);

    for (var element in jsonDecode(result.data)) {
      usermodel = UserModel.fromMap(element);
    }
    return usermodel;
  }

  Future<UserModel?> findUserModelFromId({required String id}) async {
    UserModel? usermodel;

    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/few/getUserWhereId.php?isAdd=true&id=$id';

    var result = await Dio().get(urlApi);

    for (var element in jsonDecode(result.data)) {
      usermodel = UserModel.fromMap(element);
    }
    return usermodel;
  }

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

  Future<void> readAllOrderForAdmin() async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/few/getAllOrder.php';
    var result = await Dio().get(urlApi);

    if (appController.orderWashModels.isNotEmpty) {
      appController.orderWashModels.clear();
    }

    for (var element in json.decode(result.data)) {
      OrderWashModel model = OrderWashModel.fromMap(element);

      appController.orderWashModels.add(model);
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

          //password true

          if (model.password == password) {
            if (model.status == 'officer') {
              //admin
              Get.offAll(AddminPage(userModel: model));
            } else {
              await GetStorage().write('data', model.toMap()).then(
                (value) {
                  Get.offAll(const MainHome());
                },
              );
            }
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
    String? status,
  }) async {
    String urlApiCheckEmail =
        'https://www.androidthai.in.th/fluttertraining/few/getEmailWhereEmail.php?isAdd=true&email=$email';

    var resultCheckEmail = await Dio().get(urlApiCheckEmail);

    if (resultCheckEmail.toString() == 'null') {
      //ไม่ซ้ำ
      String customerId = 'cus-${Random().nextInt(1000)}';

      String myStatus = status ?? 'user';

      String urlAppRegister =
          'https://www.androidthai.in.th/fluttertraining/few/insertUser.php?isAdd=true&customerId=$customerId&address=$address&customerName=$name&lastName=$serName&phoneNumber=$phoneNumber&lat=$lat&lng=$lng&email=$email&password=$password&status=$myStatus';

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

  Future<List<UserModel>> processReadUserWhereStatus(
      {required String status}) async {
    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/few/getUserWhereStatus.php?isAdd=true&status=$status';
    var userModels = <UserModel>[];

    var result = await Dio().get(urlAPI);
    if (result.toString() != 'null') {
      for (var element in json.decode(result.data)) {
        UserModel model = UserModel.fromMap(element);
        userModels.add(model);
      }
    }

    return userModels;
  }
}
