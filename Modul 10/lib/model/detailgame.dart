import 'package:json_annotation/json_annotation.dart';

part 'detailgame.g.dart';

@JsonSerializable()
class MinimumSystemRequirements {
  final String? os;
  final String? processor;
  final String? memory;
  final String? graphics;
  final String? storage;

  MinimumSystemRequirements({
    this.os,
    this.processor,
    this.memory,
    this.graphics,
    this.storage,
  });

  factory MinimumSystemRequirements.fromJson(Map<String, dynamic> json) =>
      _$MinimumSystemRequirementsFromJson(json);
  Map<String, dynamic> toJson() => _$MinimumSystemRequirementsToJson(this);
}

@JsonSerializable()
class Screenshot {
  final int? id;
  final String? image;

  Screenshot({this.id, this.image});

  factory Screenshot.fromJson(Map<String, dynamic> json) =>
      _$ScreenshotFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenshotToJson(this);
}

@JsonSerializable()
class DetailGame {
  final int? id;
  final String? title;
  final String? thumbnail;
  final String? status;
  final String? short_description;
  final String? description;
  final String? game_Url;
  final String? genre;
  final String? platform;
  final String? publisher;
  final String? developer;
  final String? release_date;
  final String? freetogame_profile_url;
  final MinimumSystemRequirements? minimum_system_requirements;
  final List<Screenshot>? screenshots;

  DetailGame({
    this.id,
    this.title,
    this.thumbnail,
    this.status,
    this.short_description,
    this.description,
    this.game_Url,
    this.genre,
    this.platform,
    this.publisher,
    this.developer,
    this.release_date,
    this.freetogame_profile_url,
    this.minimum_system_requirements,
    this.screenshots,
  });

  factory DetailGame.fromJson(Map<String, dynamic> json) =>
      _$DetailGameFromJson(json);
  Map<String, dynamic> toJson() => _$DetailGameToJson(this);
}
