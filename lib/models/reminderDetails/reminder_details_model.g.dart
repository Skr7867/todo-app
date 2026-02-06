// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RemindersAdapter extends TypeAdapter<Reminders> {
  @override
  final int typeId = 0;

  @override
  Reminders read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminders(
      id: fields[0] as String?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      eventStartDate: fields[3] as String?,
      isEvent: fields[4] as bool?,
      eventType: fields[5] as String?,
      reminderDate: fields[6] as String?,
      eventEndDate: fields[7] as String?,
      location: fields[8] as String?,
      allDay: fields[9] as bool?,
      category: fields[10] as String?,
      notificationTiming: fields[11] as String?,
      notificationMethods: (fields[12] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Reminders obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.eventStartDate)
      ..writeByte(4)
      ..write(obj.isEvent)
      ..writeByte(5)
      ..write(obj.eventType)
      ..writeByte(6)
      ..write(obj.eventStartDate)
      ..writeByte(7)
      ..write(obj.eventEndDate)
      ..writeByte(8)
      ..write(obj.location)
      ..writeByte(9)
      ..write(obj.allDay)
      ..writeByte(10)
      ..write(obj.category)
      ..writeByte(11)
      ..write(obj.notificationTiming)
      ..writeByte(12)
      ..write(obj.notificationMethods);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemindersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
