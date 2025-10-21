import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/movie.dart';

class MovieViewModel {
  Future<List<Movie>> fetchMovies() async {
    final String response = await rootBundle.loadString('assets/movies.json');
    final List<dynamic> data = json.decode(response);

    return data.map((json) => Movie.fromJson(json)).toList();
  }
}
