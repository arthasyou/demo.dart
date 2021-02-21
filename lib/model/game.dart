import 'package:hall/model/game_models/cover.dart';
import 'package:hall/model/game_models/genre.dart';
import 'package:hall/model/game_models/mode.dart';
import 'package:hall/model/game_models/player_perspective.dart';
import 'package:hall/model/game_models/screenshot.dart';
import 'package:hall/model/game_models/video.dart';

class GameModel {
  final int id;
  final String name;
  final CoverModel cover;
  final int createdAt;
  final int firstRelease;
  final List<ModeModel> modes;
  final List<GenreModel> genres;
  final List<PlayerPerspectiveModel> perspectives;
  final List<ScreenshotModel> screenshots;
  final String summary;
  final List<VideoModel> videos;
  final double rating;

  GameModel(
    this.id,
    this.name,
    this.cover,
    this.createdAt,
    this.firstRelease,
    this.modes,
    this.genres,
    this.perspectives,
    this.screenshots,
    this.summary,
    this.videos,
    this.rating,
  );
  GameModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        cover =
            json["cover"] == null ? null : CoverModel.fromJson(json["cover"]),
        createdAt = json["created_at"],
        firstRelease = json["first_release"],
        modes = json["game_modes"] == null
            ? null
            : (json["game_modes"] as List)
                .map((i) => ModeModel.fromJson(i))
                .toList(),
        genres = json["genres"] == null
            ? null
            : (json["genres"] as List)
                .map((i) => GenreModel.fromJson(i))
                .toList(),
        perspectives = json["player_perspectives"] == null
            ? null
            : (json["player_perspectives"] as List)
                .map((i) => PlayerPerspectiveModel.fromJson(i))
                .toList(),
        screenshots = json["screenshots"] == null
            ? null
            : (json["screenshots"] as List)
                .map((i) => ScreenshotModel.fromJson(i))
                .toList(),
        summary = json["summary"],
        videos = json["videos"] == null
            ? null
            : (json["videos"] as List)
                .map((i) => VideoModel.fromJson(i))
                .toList(),
        rating = json["rating"];
}
