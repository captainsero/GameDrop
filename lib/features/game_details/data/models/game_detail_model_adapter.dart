// Hand-written Hive TypeAdapter for GameDetailModel.
//
// This file exists because hive_ce_generator conflicts with retrofit_generator
// and injectable_generator on the source_gen/analyzer versions used by this
// project. Do NOT delete — it replaces code generation for Hive.
//
// If you add or change @HiveField annotations in game_detail_model.dart, update
// the read() and write() methods here to match.

import 'package:hive_ce/hive.dart';

import 'game_detail_model.dart';

class GameDetailModelAdapter extends TypeAdapter<GameDetailModel> {
  @override
  final int typeId = 1;

  @override
  GameDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameDetailModel(
      id: fields[0] as int,
      name: fields[1] as String,
      coverUrl: fields[2] as String?,
      releaseDate: fields[3] as String?,
      tba: fields[4] as bool,
      platforms: (fields[5] as List<dynamic>).cast<String>(),
      summary: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GameDetailModel obj) {
    writer
      ..writeByte(7) // total number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write<String?>(obj.coverUrl)
      ..writeByte(3)
      ..write<String?>(obj.releaseDate)
      ..writeByte(4)
      ..write(obj.tba)
      ..writeByte(5)
      ..write(obj.platforms)
      ..writeByte(6)
      ..write(obj.summary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
