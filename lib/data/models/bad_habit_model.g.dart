// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bad_habit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BadHabitModelAdapter extends TypeAdapter<BadHabitModel> {
  @override
  final int typeId = 3;

  @override
  BadHabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BadHabitModel(
      id: fields[0] as String,
      name: fields[1] as String,
      iconEmoji: fields[2] as String,
      quitDate: fields[3] as DateTime,
      relapses: (fields[4] as List?)?.cast<DateTime>(),
      moneySavedPerDay: fields[5] as double,
      category: fields[6] as String,
      triggers: (fields[7] as List?)?.cast<String>(),
      copingStrategies: (fields[8] as List?)?.cast<String>(),
      isArchived: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BadHabitModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconEmoji)
      ..writeByte(3)
      ..write(obj.quitDate)
      ..writeByte(4)
      ..write(obj.relapses)
      ..writeByte(5)
      ..write(obj.moneySavedPerDay)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.triggers)
      ..writeByte(8)
      ..write(obj.copingStrategies)
      ..writeByte(9)
      ..write(obj.isArchived);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadHabitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
