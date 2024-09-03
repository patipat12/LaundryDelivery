// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testdb/models/order_wash_model.dart';
import 'package:testdb/models/user_model.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/widget_button.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder({
    Key? key,
    required this.orderWashModel,
    required this.adminUserModel,
  }) : super(key: key);

  final OrderWashModel orderWashModel;
  final UserModel adminUserModel;

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    appController.receive.value = false;

    if (widget.orderWashModel.status != 'Order') {
      appController.receive.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderWashModel.refWash),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          displayStartEnd(),
          const Divider(),
          displayDetail(),
          const Divider(),
          FutureBuilder(
            future: AppServicr().findUserModelFromCustomerId(
                customerId: widget.orderWashModel.customerId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel model = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ข้อมูลผู้สั่ง : '),
                    Row(
                      children: [
                        Text(model.customerName),
                        const SizedBox(width: 16),
                        Text(model.lastName),
                      ],
                    ),
                    Text('ที่อยุ่ : ${model.address}'),
                    Text('ที่อยุ่ : ${model.phoneNumber}')
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget displayDetail() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('จำนวนเสื้อผ้า :${widget.orderWashModel.amountCloth} ชิ้น'),
            Text('ผงซักฟอก :${widget.orderWashModel.detergen}'),
            Text('น้ำยาปรับผ้านุ่ม :${widget.orderWashModel.softener}'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Obx(() => CheckboxListTile(
                    value: appController.receive.value,
                    onChanged: (value) {
                      appController.receive.value =
                          !appController.receive.value;
                    },
                    title: Text('รับสินค้า'),
                    controlAffinity: ListTileControlAffinity.leading,
                  )),
            ),
            Obx(() => appController.receive.value
                ? Text(
                    'คนรับ ; ${widget.adminUserModel.customerName} , ',
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox()),
            WidgetButton(
                onPressed: () async {
                  if (appController.receive.value) {
                    //recive

                    AppServicr().processEditStatusByIdOrder(
                        id: widget.orderWashModel.id,
                        Status: 'Recive',
                        idAdminReceive: widget.adminUserModel.id,
                        idAdminOrder: widget.orderWashModel.idAdminOrder);
                  } else {
                    AppServicr().processEditStatusByIdOrder(
                        id: widget.orderWashModel.id,
                        Status: 'Order',
                        idAdminReceive: widget.orderWashModel.idAdminReceive,
                        idAdminOrder: widget.adminUserModel.id);
                    //order
                  }
                },
                text: 'บันทึก')
          ],
        ),
      ],
    );
  }

  Row displayStartEnd() {
    return Row(
      children: [
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('วันรับผ้า'),
            Text(widget.orderWashModel.dateStart),
            Text(widget.orderWashModel.timeStart),
          ],
        )),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('วันส่งผ้า'),
            Text(widget.orderWashModel.dateEnd),
            Text(widget.orderWashModel.timeEnd),
          ],
        )),
      ],
    );
  }
}
