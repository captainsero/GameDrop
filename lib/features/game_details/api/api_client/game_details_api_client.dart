import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/game_detail_model.dart';

part 'game_details_api_client.g.dart';

@RestApi()
@injectable
// Single-method Retrofit client is intentional.
// ignore: one_member_abstracts
abstract class GameDetailsApiClient {
  @factoryMethod
  factory GameDetailsApiClient(Dio dio) = _GameDetailsApiClient;

  @GET('/games/{id}')
  Future<GameDetailModel> getGameDetail(@Path('id') int id);
}
