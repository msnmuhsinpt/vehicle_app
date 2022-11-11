// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_db.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class VehicleData extends DataClass implements Insertable<VehicleData> {
  final int id;
  final String vehicleNumber;
  final bool vehicleStatus;
  const VehicleData(
      {required this.id,
      required this.vehicleNumber,
      required this.vehicleStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_number'] = Variable<String>(vehicleNumber);
    map['vehicle_status'] = Variable<bool>(vehicleStatus);
    return map;
  }

  VehicleCompanion toCompanion(bool nullToAbsent) {
    return VehicleCompanion(
      id: Value(id),
      vehicleNumber: Value(vehicleNumber),
      vehicleStatus: Value(vehicleStatus),
    );
  }

  factory VehicleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleData(
      id: serializer.fromJson<int>(json['id']),
      vehicleNumber: serializer.fromJson<String>(json['vehicleNumber']),
      vehicleStatus: serializer.fromJson<bool>(json['vehicleStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleNumber': serializer.toJson<String>(vehicleNumber),
      'vehicleStatus': serializer.toJson<bool>(vehicleStatus),
    };
  }

  VehicleData copyWith({int? id, String? vehicleNumber, bool? vehicleStatus}) =>
      VehicleData(
        id: id ?? this.id,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        vehicleStatus: vehicleStatus ?? this.vehicleStatus,
      );
  @override
  String toString() {
    return (StringBuffer('VehicleData(')
          ..write('id: $id, ')
          ..write('vehicleNumber: $vehicleNumber, ')
          ..write('vehicleStatus: $vehicleStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, vehicleNumber, vehicleStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleData &&
          other.id == this.id &&
          other.vehicleNumber == this.vehicleNumber &&
          other.vehicleStatus == this.vehicleStatus);
}

class VehicleCompanion extends UpdateCompanion<VehicleData> {
  final Value<int> id;
  final Value<String> vehicleNumber;
  final Value<bool> vehicleStatus;
  const VehicleCompanion({
    this.id = const Value.absent(),
    this.vehicleNumber = const Value.absent(),
    this.vehicleStatus = const Value.absent(),
  });
  VehicleCompanion.insert({
    this.id = const Value.absent(),
    required String vehicleNumber,
    this.vehicleStatus = const Value.absent(),
  }) : vehicleNumber = Value(vehicleNumber);
  static Insertable<VehicleData> custom({
    Expression<int>? id,
    Expression<String>? vehicleNumber,
    Expression<bool>? vehicleStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleNumber != null) 'vehicle_number': vehicleNumber,
      if (vehicleStatus != null) 'vehicle_status': vehicleStatus,
    });
  }

  VehicleCompanion copyWith(
      {Value<int>? id,
      Value<String>? vehicleNumber,
      Value<bool>? vehicleStatus}) {
    return VehicleCompanion(
      id: id ?? this.id,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      vehicleStatus: vehicleStatus ?? this.vehicleStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleNumber.present) {
      map['vehicle_number'] = Variable<String>(vehicleNumber.value);
    }
    if (vehicleStatus.present) {
      map['vehicle_status'] = Variable<bool>(vehicleStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleCompanion(')
          ..write('id: $id, ')
          ..write('vehicleNumber: $vehicleNumber, ')
          ..write('vehicleStatus: $vehicleStatus')
          ..write(')'))
        .toString();
  }
}

class $VehicleTable extends Vehicle with TableInfo<$VehicleTable, VehicleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _vehicleNumberMeta =
      const VerificationMeta('vehicleNumber');
  @override
  late final GeneratedColumn<String> vehicleNumber = GeneratedColumn<String>(
      'vehicle_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _vehicleStatusMeta =
      const VerificationMeta('vehicleStatus');
  @override
  late final GeneratedColumn<bool> vehicleStatus = GeneratedColumn<bool>(
      'vehicle_status', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("vehicle_status" IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, vehicleNumber, vehicleStatus];
  @override
  String get aliasedName => _alias ?? 'vehicle';
  @override
  String get actualTableName => 'vehicle';
  @override
  VerificationContext validateIntegrity(Insertable<VehicleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_number')) {
      context.handle(
          _vehicleNumberMeta,
          vehicleNumber.isAcceptableOrUnknown(
              data['vehicle_number']!, _vehicleNumberMeta));
    } else if (isInserting) {
      context.missing(_vehicleNumberMeta);
    }
    if (data.containsKey('vehicle_status')) {
      context.handle(
          _vehicleStatusMeta,
          vehicleStatus.isAcceptableOrUnknown(
              data['vehicle_status']!, _vehicleStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vehicleNumber: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_number'])!,
      vehicleStatus: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}vehicle_status'])!,
    );
  }

  @override
  $VehicleTable createAlias(String alias) {
    return $VehicleTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $VehicleTable vehicle = $VehicleTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [vehicle];
}
