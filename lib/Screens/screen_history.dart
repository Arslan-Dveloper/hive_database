import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenHistory extends StatelessWidget {
  const ScreenHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
