import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ScreenPractice extends StatelessWidget {
  const ScreenPractice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Hive.openBox('nameBox'),
        builder: (context, snapshot) {
          return Center(child: Text(snapshot.data!.get('Three').toString()));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('nameBox');
          box.put('One', 'Muhammad Arslan');
          box.put('Two', 'Muhammad ');
          box.put('Three', {'name': 'Arslan', 'int': 40});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
