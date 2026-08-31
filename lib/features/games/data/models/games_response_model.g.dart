// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamesResponseModel _$GamesResponseModelFromJson(Map<String, dynamic> json) =>
    GamesResponseModel(
      count: (json['count'] as num).toInt(),
      next: json['next'] as bool,
      results: (json['results'] as List<dynamic>)
          .map((e) => GameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GamesResponseModelToJson(GamesResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'results': instance.results,
    };
