// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BMIAdapter extends TypeAdapter<BMI> {
  @override
  final int typeId = 1;

  @override
  BMI read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BMI(
      weight: fields[0] as double,
      height: fields[1] as double,
      gender: fields[2] as String,
    )
      ..bmi = fields[3] as double
      ..status = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, BMI obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.weight)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.bmi)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BMIAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
