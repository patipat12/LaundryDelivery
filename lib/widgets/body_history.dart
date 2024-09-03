import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';

class BodyHistory extends StatefulWidget {
  const BodyHistory({super.key});

  @override
  State<BodyHistory> createState() => _BodyHistoryState();
}

class _BodyHistoryState extends State<BodyHistory> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    print('history work');
    if (appController.currentUserModels.isEmpty) {
      AppServicr().findCuttentUserLogin().then((value) {
        AppServicr().readAllOrder();
      });
    } else {
      AppServicr().readAllOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.orderWashModels.isEmpty
        ? const SizedBox()
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: appController.orderWashModels.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(appController.orderWashModels[index].refWash),
                      Text(
                          ' Status :  ${appController.orderWashModels[index].status}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'รับผ้า : ${appController.orderWashModels[index].dateStart}'),
                      Text(
                          'ส่งผ้า : ${appController.orderWashModels[index].dateEnd}'),
                    ],
                  )
                ],
              ),
            ),
          ));
  }
}
