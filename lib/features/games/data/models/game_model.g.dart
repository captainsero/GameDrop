// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  coverUrl: json['coverUrl'] as String?,
  releaseDate: json['releaseDate'] as String?,
  tba: json['tba'] as bool,
  platforms: (json['platforms'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'coverUrl': instance.coverUrl,
  'releaseDate': instance.releaseDate,
  'tba': instance.tba,
  'platforms': instance.platforms,
};
