// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testdb/models/user_model.dart';
import 'package:testdb/screens/chat_wuth_customer.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';

class GridCustomer extends StatefulWidget {
  const GridCustomer({
    Key? key,
    required this.usermodel,
  }) : super(key: key);

  final UserModel usermodel;

  @override
  State<GridCustomer> createState() => _GridCustomerState();
}

class _GridCustomerState extends State<GridCustomer> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppServicr().processReadAllmessageCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Officer : ${widget.usermodel.customerName}'),
      ),
      body: Obx(() => appController.customerChatUserModels.isEmpty
          ? SizedBox()
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: appController.customerChatUserModels.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(ChatWithCustomer(
                    customerId:
                        appController.customerChatUserModels[index].customerId,
                    customerIdAdmin: widget.usermodel.customerId,
                  ));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Text(
                      appController.customerChatUserModels[index].customerName),
                ),
              ),
            )),
    );
  }
}
