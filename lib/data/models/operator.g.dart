// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperatorAdapter extends TypeAdapter<Operator> {
  @override
  final int typeId = 0;

  @override
  Operator read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Operator(
      userId: fields[0] as String,
      userName: fields[1] as String,
      userProfile: fields[3] as String,
      userEmail: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Operator obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.userEmail)
      ..writeByte(3)
      ..write(obj.userProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
