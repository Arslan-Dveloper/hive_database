import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_database_batch_five/Controller/my_Maps_Controller.dart';
import 'package:hive_database_batch_five/Screens/screen_history.dart';

class ScreenMyMap extends StatelessWidget {
  const ScreenMyMap({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var controller = Get.put(MyMapController());
    GoogleMapController? googleMapController;
    Rx<Marker> resultMarker = Rx(
      Marker(
        markerId: MarkerId('results'),
        position: LatLng(30.970151530361814, 70.94363684924707),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.cyan.withOpacity(0.3),
        title: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Container(
            height: Get.height * 0.1,
            width: Get.width * .8,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Write your address',
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: searchController,
            ),
          ),
        ),
        actions: [
          IconButton(
            // onPressed: () {
            //   var query = searchController.text;
            //   controller.showResultDialog(
            //     query,
            //     context,
            //     onResultTap: (lat, lng) {
            //       if (googleMapController != null) {
            //         googleMapController!.moveCamera(
            //           CameraUpdate.newCameraPosition(
            //             CameraPosition(
            //               target: LatLng(lat, lng),
            //               zoom: 18,
            //             ),
            //           ),
            //         );
            //       }
            //     },
            //   );
            // },
            onPressed: () async {
              var query = searchController.text;
              var box = await Hive.openBox('MapData');
              controller.showResultDialog(
                query,
                context,
                onResultTap: (lat, lng, address) {
                  if (googleMapController != null) {
                    googleMapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(lat, lng),
                          zoom: 16,
                        ),
                      ),
                    );
                    resultMarker.value = Marker(
                        markerId: MarkerId('results'),
                        position: LatLng(lat, lng),
                        infoWindow: InfoWindow(title: address));
                  }
                },
              );
            },
            icon: Icon(Icons.search),
          ),
          GestureDetector(
            onTap: () {
              Get.to(ScreenHistory());
            },
            child: Icon(Icons.history),
          ),
        ],
      ),
      body: Obx(() {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(30.970151530361814, 70.94363684924707),
            zoom: 16,
          ),
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          markers: {resultMarker.value},
        );
      }),
    );
  }
}

// 30.970151530361814, 70.94363684924707
