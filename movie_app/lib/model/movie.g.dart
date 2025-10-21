// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  title: json['title'] as String,
  overview: json['overview_id'] as String,
  posterPath: json['poster_path'] as String,
  releaseDate: json['release_date'] as String,
  category: json['category'] as String,
  isPopular: json['is_popular'] as bool,
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'title': instance.title,
  'overview_id': instance.overview,
  'poster_path': instance.posterPath,
  'release_date': instance.releaseDate,
  'category': instance.category,
  'is_popular': instance.isPopular,
};
