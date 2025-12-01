// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stone_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoneModelAdapter extends TypeAdapter<StoneModel> {
  @override
  final int typeId = 4;

  @override
  StoneModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoneModel(
      id: fields[0] as String,
      name: fields[1] as String,
      emoji: fields[2] as String,
      description: fields[3] as String,
      themeColorValues: (fields[4] as List).cast<int>(),
      rarity: fields[5] as String,
      isUnlocked: fields[6] as bool,
      unlockCondition: fields[7] as String,
      unlockedAt: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, StoneModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.emoji)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.themeColorValues)
      ..writeByte(5)
      ..write(obj.rarity)
      ..writeByte(6)
      ..write(obj.isUnlocked)
      ..writeByte(7)
      ..write(obj.unlockCondition)
      ..writeByte(8)
      ..write(obj.unlockedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoneModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
