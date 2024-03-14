import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class MyMapController extends GetxController {
  void showResultDialog(String address, BuildContext context,
      {required Function(double lat, double lng, String clickedAddress)
          onResultTap}) async {
    var locations = await geocoding.locationFromAddress(address);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${address}'),
          content: SingleChildScrollView(
            child: Column(
              children: locations.map((e) {
                return FutureBuilder(
                  future: geocoding.placemarkFromCoordinates(
                      e.latitude, e.longitude),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    var data = snapshot.data;
                    var locality = data?.first.locality ?? 'Unknown';
                    var administrativeArea =
                        data?.first.administrativeArea ?? 'Unknown';
                    return ListTile(
                      title: Text('${administrativeArea}, ${locality}'),
                      onTap: () {
                        Get.back();
                        onResultTap(e.latitude, e.longitude,
                            '${administrativeArea}, ${locality}');
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
