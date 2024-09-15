import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/widgets/body_list_customer_owner.dart';
import 'package:testdb/widgets/body_list_history_owner.dart';
import 'package:testdb/widgets/body_list_officer_owner.dart';
import 'package:testdb/widgets/body_list_income_owner.dart';
import 'package:testdb/widgets/widget_button.dart';
import 'package:testdb/widgets/widget_singout.dart';

class MainHomeOwnerShop extends StatefulWidget {
  const MainHomeOwnerShop({super.key});

  @override
  State<MainHomeOwnerShop> createState() => _MainHomeOwnerShopState();
}

class _MainHomeOwnerShopState extends State<MainHomeOwnerShop> {
  AppController appcontroller = Get.put(AppController());
  var bodys = <Widget>[
    const BodyListOfficerOwner(),
    const BodyListCustomerOwner(),
    const BodyListIncomeOwner(),
    const BodyListHistoryOwner(),
  ];
  var titles = <String>[
    'Officer',
    'Customer',
    'Income',
    'History',
  ];
  var iconsData = <IconData>[
    Icons.group,
    Icons.face,
    Icons.money,
    Icons.history,
  ];
  List<BottomNavigationBarItem> items = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < bodys.length; i++) {
      items.add(
          BottomNavigationBarItem(icon: Icon(iconsData[i]), label: titles[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(titles[appcontroller.indexBody.value]),
            actions: const [
              WidgetSignOut(),
            ],
          ),
          body: bodys[appcontroller.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed,
            currentIndex: appcontroller.indexBody.value,
            items: items,
            onTap: (value) {
              appcontroller.indexBody.value = value;
            },
          ),
        ));
  }
}
