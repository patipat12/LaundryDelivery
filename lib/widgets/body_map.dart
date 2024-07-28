import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';

class BodyMap extends StatefulWidget {
  const BodyMap({super.key});

  @override
  State<BodyMap> createState() => _BodyMapState();
}

class _BodyMapState extends State<BodyMap> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AppServicr().processFinPosition();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(
      init: AppController(),
      initState: (_) {},
      builder: (AppController appController) {
        return appController.positions.isEmpty
            ? const SizedBox()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(appController.positions.last.latitude, appController.positions.last.longitude), zoom: 16));
      },
    );
  }
}
