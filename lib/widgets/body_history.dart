import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testdb/screens/chooseproduct.dart';

import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';
import 'package:testdb/widgets/body_news.dart';

class BodyHistory extends StatefulWidget {
  const BodyHistory({super.key});

  @override
  State<BodyHistory> createState() => _BodyHistoryState();
}

class _BodyHistoryState extends State<BodyHistory> {
  Map<MarkerId, Marker> mapMarker = {};

  AppController controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppServicr().processFinPosition().then((value) {
      print("## ${controller.positions.last}");
    });

    createMarker();
  }

  void createMarker() async {
    double markerLat = 16.244241683714726;
    double markerLng = 103.24954788263122;

    BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), 'assets/images/icon64.png');

    MarkerId markerId = const MarkerId('shop');
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(markerLat, markerLng),
      icon: bitmapDescriptor,
      onTap: () {
        Get.to(ChooseProduct());
      },
    );

    mapMarker[markerId] = marker;
  }

  void _showNotification() {
    // Navigate to the BodyNews page when the notification icon is pressed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BodyNews()), // Navigate to BodyNews
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Map View'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: _showNotification, // Navigate to BodyNews
          ),
        ],
      ),
      body: GetX<AppController>(
        init: AppController(),
        initState: (_) {},
        builder: (AppController appController) {
          return appController.positions.isEmpty
              ? const SizedBox()
              : GoogleMap(
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(appController.positions.last.latitude,
                        appController.positions.last.longitude),
                    zoom: 16,
                  ),
                  markers: Set<Marker>.of(mapMarker.values),
                );
        },
      ),
    );
  }
}
