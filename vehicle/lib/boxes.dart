import 'package:hive/hive.dart';
import 'package:vehicle_app/db/vehicle_db.dart';

class Boxes {
  static Box<Vehicle> getData() => Hive.box<Vehicle>('vehicle');
}
