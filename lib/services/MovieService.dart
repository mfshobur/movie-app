import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/movie.dart';
import 'package:movie_app/data/movie_detail.dart';

class MovieService {
  static Future<List<Results>> getMovieList() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=1a5ba960b512ee0017ec8b29ad872700&language=en-US&page=1'));

      if (response.statusCode == 200) {
        var movie = Movie.fromJson(jsonDecode(response.body));
        return movie.results!;
      } else {
        throw Exception('Failed to load movie');
      }
    } catch (e) {
      return [];
    }
  }

  static Future<MovieDetail> getMovieDetail(int id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${id}?api_key=1a5ba960b512ee0017ec8b29ad872700&language=en-US'));
      print(response.body);
      if (response.statusCode == 200) {
        var movieDetail = MovieDetail.fromJson(jsonDecode(response.body));
        return movieDetail;
      } else {
        throw Exception('Failed to load detail');
      }
    } catch (e) {
      return MovieDetail();
    }
  }
}
