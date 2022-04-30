// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationDataModelAdapter extends TypeAdapter<NotificationDataModel> {
  @override
  final int typeId = 0;

  @override
  NotificationDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationDataModel(
      id: fields[0] as int?,
      title: fields[1] as String?,
      subTitle: fields[2] as String?,
      status: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subTitle)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
