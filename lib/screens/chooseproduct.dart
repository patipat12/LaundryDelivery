import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdb/utility/app_constant.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';

class ChooseProduct extends StatefulWidget {
  const ChooseProduct({super.key});

  @override
  State<ChooseProduct> createState() => _ChooseProductState();
}

class _ChooseProductState extends State<ChooseProduct> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby wash'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              displatStartWork(context),
              displayEndWork(context),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/wash1.png', width: 100),
                  const Text('เครื่องซักผ้า 40-'),
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/wash2.png', width: 100),
                  const Text('เครื่องอบผ้า 40-'),
                  Obx(() => Checkbox(
                        value: appController.optionDryClothes.value,
                        onChanged: (value) {
                          appController.optionDryClothes.value =
                              !appController.optionDryClothes.value;
                        },
                      ))
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('จำนวนเสื้อผ้า ชิ้นละ5'),
              SizedBox(
                width: 100,
                child: Obx(() => DropdownButton(
                      hint: Text('เลือกจำน'),
                      value: appController.ChooseAmountCloth.last,
                      items: AppConstant.amountCloth
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        appController.ChooseAmountCloth.add(value);
                      },
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('น้ำยาซักผ้า'),
              SizedBox(
                width: 100,
                child: Obx(() => DropdownButton(
                      hint: Text('เลือกจำน'),
                      value: appController.ChooseAmountDetergent.last,
                      items: AppConstant.amountOption
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        appController.ChooseAmountDetergent.add(value);
                      },
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('น้ำยาปรับผ้านุ่ม'),
              SizedBox(
                width: 100,
                child: Obx(() => DropdownButton(
                      hint: Text('เลือกจำน'),
                      value: appController.ChooseAmountSofeterner.last,
                      items: AppConstant.amountOption
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        appController.ChooseAmountSofeterner.add(value);
                      },
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ราคารวม: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 8,
              ),
              Obx(() => Text(
                    ' ${(appController.optionWashClothes.value ? 40 : 0) + (appController.optionDryClothes.value ? 40 : 0) + (appController.ChooseAmountCloth.last != null ? 5 * appController.ChooseAmountCloth.last! : 0) + (appController.ChooseAmountDetergent.last != null ? 10 * appController.ChooseAmountDetergent.last! : 0) + (appController.ChooseAmountSofeterner.last != null ? 10 * appController.ChooseAmountSofeterner.last! : 0)}บาท',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
      floatingActionButton: WidgetButton(
          onPressed: () {
            if ((appController.chooseStartWorkDateTimes.isEmpty) ||
                (appController.chooseStartWorkHHmm.last == null)) {
              Get.snackbar('เวลารับผ้า', 'กรุณาเลือกเวลารับผ้า');
            } else if ((appController.chooseEndWorkDateTimes.isEmpty) ||
                (appController.chooseEndWorkHHmm.last == null)) {
              Get.snackbar('เวลาส่งผ้า', 'กรุณาเลือกเวลาส่งผ้า');
            } else if (appController.ChooseAmountCloth.last == null) {
              Get.snackbar('จำนวนเสื้อผ้า', 'กรุณาเลือกจำนวนเสื้อผ้า');
            } else if (appController.ChooseAmountDetergent.last == null) {
              Get.snackbar('จำนวนน้ำยาซักผ้า', 'กรุณาเลือกน้ำยาเสื้อผ้า');
            } else if (appController.ChooseAmountSofeterner.last == null) {
              Get.snackbar(
                  'จำนวนน้ำยาปรับผ้านุ่ม', 'กรุณาเลือกน้ำยาปรับผ้านุ่ม');
            } else {}
          },
          text: 'ORDER'),
    );
  }

  InkWell displayEndWork(BuildContext context) {
    return InkWell(
      onTap: () async {
        var endWorkDataTime = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)));

        if (endWorkDataTime != null) {
          appController.chooseEndWorkDateTimes.add(endWorkDataTime);

          final keyForm = GlobalKey<FormState>();

          AppDialog().normalDialog(
              title: 'เลือกเวลา',
              contentWidget: Form(
                key: keyForm,
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'กรุณาเลือกวัน';
                    } else {
                      return null;
                    }
                  },
                  hint: const Text('โปรดเลือกช่วงเวลา'),
                  value: appController.chooseEndWorkHHmm.last,
                  items: AppConstant.dateTimes
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(AppServicr().changDateTimeToString(
                              dateTime: e, timeFormat: 'HH:mm')),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    appController.chooseEndWorkHHmm.add(value!);
                  },
                ),
              ),
              seconAction: WidgetButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      Get.back();
                    }
                  },
                  text: 'ok'));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('เวลาส่งผ้า'),
            Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(appController.chooseEndWorkDateTimes.isEmpty
                        ? 'dd/mm/ yy'
                        : AppServicr().changDateTimeToString(
                            dateTime:
                                appController.chooseEndWorkDateTimes.last)),
                    const SizedBox(width: 8),
                    Text(appController.chooseEndWorkHHmm.last == null
                        ? 'HH:mm'
                        : AppServicr().changDateTimeToString(
                            dateTime: appController.chooseEndWorkHHmm.last!,
                            timeFormat: 'HH:mm')),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  InkWell displatStartWork(BuildContext context) {
    return InkWell(
      onTap: () async {
        var startWorkDataTime = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)));

        if (startWorkDataTime != null) {
          appController.chooseStartWorkDateTimes.add(startWorkDataTime);

          final keyForm = GlobalKey<FormState>();

          AppDialog().normalDialog(
              title: 'เลือกเวลา',
              contentWidget: Form(
                key: keyForm,
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'กรุณาเลือกวัน';
                    } else {
                      return null;
                    }
                  },
                  hint: const Text('โปรดเลือกช่วงเวลา'),
                  value: appController.chooseStartWorkHHmm.last,
                  items: AppConstant.dateTimes
                      .map((e) => DropdownMenuItem(
                            child: Text(AppServicr().changDateTimeToString(
                                dateTime: e, timeFormat: 'HH:mm')),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    appController.chooseStartWorkHHmm.add(value!);
                  },
                ),
              ),
              seconAction: WidgetButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      Get.back();
                    }
                  },
                  text: 'ok'));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('เวลารับผ้า'),
            Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(appController.chooseStartWorkDateTimes.isEmpty
                        ? 'dd/mm/ yy'
                        : AppServicr().changDateTimeToString(
                            dateTime:
                                appController.chooseStartWorkDateTimes.last)),
                    const SizedBox(width: 8),
                    Text(appController.chooseStartWorkHHmm.last == null
                        ? 'HH:mm'
                        : AppServicr().changDateTimeToString(
                            dateTime: appController.chooseStartWorkHHmm.last!,
                            timeFormat: 'HH:mm')),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
