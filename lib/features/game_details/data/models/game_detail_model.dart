import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/game_detail_entity.dart';

part 'game_detail_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class GameDetailModel {
  const GameDetailModel({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.releaseDate,
    required this.tba,
    required this.platforms,
    required this.summary,
  });

  factory GameDetailModel.fromJson(Map<String, dynamic> json) =>
      _$GameDetailModelFromJson(json);

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? coverUrl;

  @HiveField(3)
  final String? releaseDate;

  @HiveField(4)
  final bool tba;

  @HiveField(5)
  final List<String> platforms;

  @HiveField(6)
  final String summary;

  Map<String, dynamic> toJson() => _$GameDetailModelToJson(this);

  GameDetailEntity toEntity() {
    return GameDetailEntity(
      id: id,
      name: name,
      coverUrl: coverUrl,
      releaseDate: releaseDate != null ? DateTime.tryParse(releaseDate!) : null,
      tba: tba,
      platforms: platforms,
      summary: summary,
    );
  }
}
