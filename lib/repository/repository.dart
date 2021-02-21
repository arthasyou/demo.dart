import 'dart:convert';

import 'package:hall/model/game_response.dart';
import 'package:http/http.dart' as http;

class GameRepository {
  static String mainUrl = 'https://api.igdb.com/v4';
  var gameListUrl = '$mainUrl/games';
  final String clientId = 'cj5olxq0mznok2bz3k14s3zb8cijrl';
  final String authorization = 'p3nssh39k5to89yukow20eji3g7y0d';

  Future<GameResponse> getGames() async {
    var response = await http.post(gameListUrl,
        headers: {
          "Accept": "application/json",
          "Client-ID": "$clientId",
          "Authorization": "Bearer $authorization"
        },
        body:
            "fields artworks,bundles,category,checksum,collection,cover.*,created_at,first_release_date,follows,game_engines,game_modes.*,genres.*,name,parent_game,player_perspectives.*,rating,rating_count,screenshots.*,summary,total_rating,total_rating_count,url,videos.*;where cover.image_id != null & genres != null & videos != null & created_at > 1252214987 & platforms = 48 & rating > 80; limit 100; sort rating desc;");
    // print("${response.statusCode}");
    // print("body: ${response.body}");
    return GameResponse.fromJson(jsonDecode(response.body));
  }

  Future<GameResponse> getSlider() async {
    var response = await http.post(gameListUrl,
        headers: {
          "Accept": "application/json",
          "Client-ID": "$clientId",
          "Authorization": "Bearer $authorization"
        },
        body:
            "fields artworks,bundles,category,checksum,collection,cover.*,created_at,first_release_date,follows,game_engines,game_modes.*,genres.*,name,parent_game,player_perspectives.*,rating,rating_count,screenshots.*,summary,total_rating,total_rating_count,url,videos.*;where cover.image_id != null & genres != null & videos != null & created_at > 1252214987 & platforms = 48 & rating > 80; limit 100; sort created_at asc;");
    // print("code ${response.statusCode}");
    // print("body: ${response.body}");
    return GameResponse.fromJson(jsonDecode(response.body));
  }
}
