// Hand-written Hive TypeAdapter for GameModel.
//
// This file exists because hive_ce_generator conflicts with retrofit_generator
// and injectable_generator on the source_gen/analyzer versions used by this
// project. Do NOT delete — it replaces code generation for Hive.
//
// If you add or change @HiveField annotations in game_model.dart, update
// the read() and write() methods here to match.

import 'package:hive_ce/hive.dart';

import 'game_model.dart';

class GameModelAdapter extends TypeAdapter<GameModel> {
  @override
  final int typeId = 0;

  @override
  GameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameModel(
      id: fields[0] as int,
      name: fields[1] as String,
      coverUrl: fields[2] as String?,
      releaseDate: fields[3] as String?,
      tba: fields[4] as bool,
      platforms: (fields[5] as List<dynamic>).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GameModel obj) {
    writer
      ..writeByte(6) // total number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.coverUrl)
      ..writeByte(3)
      ..write(obj.releaseDate)
      ..writeByte(4)
      ..write(obj.tba)
      ..writeByte(5)
      ..write(obj.platforms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
