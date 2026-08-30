import 'package:json_annotation/json_annotation.dart';

import 'game_model.dart';

part 'games_response_model.g.dart';

@JsonSerializable()
class GamesResponseModel {
  const GamesResponseModel({
    required this.count,
    required this.next,
    required this.results,
  });

  factory GamesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GamesResponseModelFromJson(json);

  final int count;
  final bool next;
  final List<GameModel> results;

  Map<String, dynamic> toJson() => _$GamesResponseModelToJson(this);
}
