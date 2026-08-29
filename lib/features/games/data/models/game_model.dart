import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/game_entity.dart';

part 'game_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class GameModel {
  const GameModel({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.releaseDate,
    required this.tba,
    required this.platforms,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? coverUrl;

  @HiveField(3)
  final String? releaseDate; // kept as raw "YYYY-MM-DD" string in storage

  @HiveField(4)
  final bool tba;

  @HiveField(5)
  final List<String> platforms;

  Map<String, dynamic> toJson() => _$GameModelToJson(this);

  GameEntity toEntity() {
    return GameEntity(
      id: id,
      name: name,
      coverUrl: coverUrl,
      releaseDate: releaseDate != null ? DateTime.tryParse(releaseDate!) : null,
      tba: tba,
      platforms: platforms,
    );
  }
}
