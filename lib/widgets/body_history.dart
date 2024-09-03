import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:testdb/utility/app_Take_photo.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_dialog.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';

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
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                AppDialog().normalDialog(
                  title: appController.orderWashModels[index].refWash,
                  contentWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'วันรับผ้า : ${appController.orderWashModels[index].dateStart}'),
                      Text(
                          'เวลารับผ้า : ${appController.orderWashModels[index].timeStart}'),
                      const Divider(),
                      Text(
                          'วันส่งผ้า : ${appController.orderWashModels[index].dateEnd}'),
                      Text(
                          'เวลาส่งผ้า : ${appController.orderWashModels[index].timeEnd}'),
                      const Divider(),
                      CheckboxListTile(
                        value: bool.parse(
                            appController.orderWashModels[index].dry),
                        title: const Text('เครื่องอบผ้า'),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (Value) {},
                      ),
                      const Divider(),
                      Text(
                          'จำนวนเสื้อผ้า : ${appController.orderWashModels[index].amountCloth} ชิ้น '),
                      Text(
                          'ผงซักฟอก : ${appController.orderWashModels[index].detergen}  '),
                      Text(
                          'น้ำยาปรับผ้านุ่ม : ${appController.orderWashModels[index].softener}  '),
                      const Divider(),
                      Text(
                        'ค่าใช้จ่ายทั้งหมด : ${appController.orderWashModels[index].total} บาท',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w200),
                      ),




                      appController.orderWashModels[index].status == 'Order'
                          ? Text('รอรับผ้าก่อน แล้วจ่าย พร้อมเพยื ',
                              style: TextStyle(fontSize: 10,color: GFColors.DANGER))
                          : appController.orderWashModels[index].status == 'Receive' ? Image.network(
                              'https://promptpay.io/0928133081/${appController.orderWashModels[index].total}') : Image.network(appController.orderWashModels[index].urlSlip),
                    ],




                  ),
                  firstAction: appController.orderWashModels[index].status ==
                          'Order'
                      ? null
                      : appController.orderWashModels[index].status == 'Receive' ?  WidgetButton(
                          onPressed: () async {
                            String url =
                                'https://promptpay.io/0928133081/${appController.orderWashModels[index].total}';

                            var response = await Dio().get(url,
                                options:
                                    Options(responseType: ResponseType.bytes));

                            final result = await ImageGallerySaver.saveImage(
                                Uint8List.fromList(response.data),
                                quality: 60,
                                name: 'Prompay');

                            if (result['isSuccess']) {
                              Get.back();
                              Get.snackbar('โหลด สำเร้จ', 'เปิดแอพธนาคารแสกน ');
                            }
                          },
                          text: 'โหลดQrcodr',
                          type: GFButtonType.outline2x,
                        ) : null,
                  thirdAction:
                      appController.orderWashModels[index].status == 'Order'
                          ? null
                          : appController.orderWashModels[index].status == 'Receive' ? WidgetButton(
                              onPressed: () async {
                                await AppTakePhoto().uploadImage().then(
                                  (value)async {
                                    String urlSlip = value;
                                    print('##3sep urlSlip --> $urlSlip');

                                    String urlEditUrlSlip =
                                        'https://www.androidthai.in.th/fluttertraining/few/editUrlSlipWhereId.php?isAdd=true&id=${appController.orderWashModels[index].id}&status=payment&urlSlip=$urlSlip';

                                              await Dio().get(urlEditUrlSlip).then((value) {
                                                Get.back();
                                                AppServicr().readAllOrder();
                                              });
                                        
                                  },
                                );
                              },
                              text: 'อัพโหลดสลีป',
                              type: GFButtonType.outline2x,
                            ) : null,
                );
              },
              child: Container(
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
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color:
                                  appController.orderWashModels[index].status ==
                                          'Order'
                                      ? const Color.fromARGB(255, 125, 214, 128)
                                      : appController.orderWashModels[index].status == 'Receive' ? Colors.amber : Color.fromARGB(255, 225, 140, 168)),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                              ' Status :  ${appController.orderWashModels[index].status}'),
                        ),
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
            ),
          ));
  }
}
