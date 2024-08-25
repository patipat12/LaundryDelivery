import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/user_model.dart';

class AppController extends GetxController {
  RxList positions = <Position>[].obs;

  RxInt indexBody = 0.obs;

  RxList<DateTime> chooseStartWorkDateTimes = <DateTime>[].obs;
  RxList<DateTime?> chooseStartWorkHHmm = <DateTime?>[null].obs;

  RxList<DateTime> chooseEndWorkDateTimes = <DateTime>[].obs;
  RxList<DateTime?> chooseEndWorkHHmm = <DateTime?>[null].obs;

  RxBool optionWashClothes = true.obs;
  RxBool optionDryClothes = false.obs;

  RxList<int?> ChooseAmountCloth = <int?>[null].obs;
  RxList<int?> ChooseAmountDetergent = <int?>[null].obs;
  RxList<int?> ChooseAmountSofeterner = <int?>[null].obs;
  
  RxInt total = 0.obs;

  RxList <UserModel> currentUserModels = <UserModel>[].obs;

  RxList <OrderWashModel>orderWashModels = <OrderWashModel>[].obs;
  
  }
