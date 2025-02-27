// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripInfoAdapter extends TypeAdapter<TripInfo> {
  @override
  final int typeId = 0;

  @override
  TripInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripInfo()
      ..title = fields[0] as String
      ..location = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, TripInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
