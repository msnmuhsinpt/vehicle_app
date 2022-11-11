import 'dart:developer';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'vehicle_db.g.dart';

class Vehicle extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get vehicleNumber => text()();

  BoolColumn get vehicleStatus =>
      boolean().withDefault(const Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  Vehicle,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  //get all data from db
  Future<List<VehicleData>> getVehicleList() async {
    return await select(vehicle).get();
  }

  //INSERT new vehicle into db
  Future<int> insertVehicle(VehicleCompanion vehicleCompanion) async {
    return await into(vehicle).insert(vehicleCompanion);
  }

  // UPDATE Vehicle
  Future<bool> updateVehicle(VehicleData vehicleData) async {
    return await update(vehicle).replace(vehicleData);
  }
}
