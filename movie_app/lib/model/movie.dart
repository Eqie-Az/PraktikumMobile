import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String title;

  @JsonKey(name: 'overview_id')
  final String overview; // gunakan overview_id dari JSON

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  final String category;

  @JsonKey(name: 'is_popular')
  final bool isPopular;

  Movie({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.category,
    required this.isPopular,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
