import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/app_keys/api_keys.dart';
import '../../data/models/games_response_model.dart';

part 'games_api_client.g.dart';

@RestApi()
@injectable
//
// ignore: one_member_abstracts
abstract class GamesApiClient {
  @factoryMethod
  factory GamesApiClient(Dio dio) = _GamesApiClient;

  @GET(ApiKeys.upcomingGames)
  Future<GamesResponseModel> getUpcomingGames(@Query('page') int page);
}
