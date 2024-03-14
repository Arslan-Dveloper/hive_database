import 'package:hive/hive.dart';
part 'myMapClass.g.dart';

class myMapClassData {
  @HiveField(0)
  double? latitude;
  @HiveField(1)
  double? languitude;
  @HiveField(2)
  String? placeName;
  @HiveField(3)
  int? timeStamp;

  myMapClassData({
    required this.latitude,
    required this.languitude,
    required this.placeName,
    required this.timeStamp,
  });
}
