import 'package:hive/hive.dart';

part 'vehicle_db.g.dart';

@HiveType(typeId: 0)
class Vehicle extends HiveObject {
  @HiveField(0)
  late String number;
  @HiveField(1)
  late bool isRunning = false;
}
