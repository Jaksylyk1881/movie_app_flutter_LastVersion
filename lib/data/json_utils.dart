import 'package:movie_app/data/model/movie.dart';

import 'networking.dart';

enum Sorting {
  popularity,
  topRated,
}

class JsonUtils {
  final String _baseUrl = 'https://api.themoviedb.org/3/discover/movie';
  final String _apikey = '4e1808f48673a589b0697bd4184f1edc';
  final String language = 'ru-RU';
  final String _sortPopularity = 'popularity.desc';
  final String _sortTopRated = 'vote_average.desc';

  Future<List<Movie>> getMovies(Sorting sortType, int page) async {
    List<Movie> movies = [];
    final NetworkHelper networkHelper = NetworkHelper(
      '$_baseUrl?api_key=$_apikey&language=$language&sort_by=${(sortType == Sorting.popularity) ? _sortPopularity : _sortTopRated}&page=$page&vote_count.gte=10000',
    );
    final data = await networkHelper.getData();
    final Iterable results = await data['results'] as Iterable;
    movies = results.map((movie) => Movie.fromJson(movie as Map<String, dynamic>)).toList();
    return movies;
  }
}
