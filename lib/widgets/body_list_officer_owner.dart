import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/screens/register.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';

class BodyListOfficerOwner extends StatefulWidget {
  const BodyListOfficerOwner({super.key});

  @override
  State<BodyListOfficerOwner> createState() => _BodyListOfficerOwnerState();
}

class _BodyListOfficerOwnerState extends State<BodyListOfficerOwner> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          FutureBuilder(
            future: AppServicr().processReadUserWhereStatus(status: 'officer'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userModels = snapshot.data;
                if (userModels!.isEmpty) {
                  return const Center(child: Text('ไม่มีพนักงาน'));
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: userModels.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      'ชื่อ : ${userModels[index].customerName}')),
                              Expanded(
                                  child: Text(
                                      'นามสกุล : ${userModels[index].lastName}')),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                      'ชื่อที่อยู่ : ${userModels[index].address}')),
                              Expanded(
                                  child: Text(
                                      'เบอโทร : ${userModels[index].phoneNumber}')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 0,
            right: 16,
            child: WidgetButton(
              onPressed: () {
                Get.to(Register(status: 'officer'))?.then((value) {
                  setState(() {});
                });
              },
              text: 'เพิ่ม officer',
            ),
          ),
        ],
      ),
    );
  }
}
