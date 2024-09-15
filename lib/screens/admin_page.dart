// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testdb/models/user_model.dart';
import 'package:testdb/screens/detail.dart';
import 'package:testdb/utility/app_constant.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_singout.dart';

class AddminPage extends StatefulWidget {
  const AddminPage({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  State<AddminPage> createState() => _AddminPageState();
}

class _AddminPageState extends State<AddminPage> {
  AppController appcontroller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppServicr().readAllOrderForAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('officer โดย ${widget.userModel.customerName}'),actions: [const WidgetSignOut()],
      ),
      body: Obx(() => appcontroller.orderWashModels.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: appcontroller.orderWashModels.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(DetailOrder(
                    orderWashModel: appcontroller.orderWashModels[index],
                    adminUserModel: widget.userModel,
                  ))?.then((value) {
                    AppServicr().readAllOrderForAdmin();
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(appcontroller.orderWashModels[index].refWash),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: appcontroller
                                            .orderWashModels[index].status ==
                                        'Order'
                                    ? Colors.green
                                    : appcontroller.orderWashModels[index]
                                                .status ==
                                            'Receive'
                                        ? Colors.orange
                                        : appcontroller.orderWashModels[index]
                                                    .status ==
                                                'Payment'
                                            ? Colors.pink.shade200
                                            : Colors.blue),
                            child: Text(
                                appcontroller.orderWashModels[index].status),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(appcontroller.orderWashModels[index].dateStart),
                          Text(appcontroller.orderWashModels[index].dateEnd),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
    );
  }
}
