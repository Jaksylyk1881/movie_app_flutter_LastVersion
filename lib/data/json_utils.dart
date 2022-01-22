import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/model/video.dart';

import 'model/review.dart';
import 'networking.dart';

enum Sorting {
  popularity,
  topRated,
}

class JsonUtils {
  final String _baseUrl = 'https://api.themoviedb.org/3/discover/movie';
  final String _apikey = '4e1808f48673a589b0697bd4184f1edc';
  final String language = 'En-en';
  final String _sortPopularity = 'popularity.desc';
  final String _sortTopRated = 'vote_average.desc';


  final String _baseUrlForReviewsOrVideos = 'https://api.themoviedb.org/3/movie/';

  Future<List<Movie>> getMovies(Sorting sortType, int page) async {
    final NetworkHelper networkHelper = NetworkHelper(
      '$_baseUrl?api_key=$_apikey&language=$language&sort_by=${(sortType == Sorting.popularity) ? _sortPopularity : _sortTopRated}&page=$page&vote_count.gte=10000',
    );
    final data = await networkHelper.getData();
    final Iterable results = await data['results'] as Iterable;
    return results.map((movie) => Movie.fromJson(movie as Map<String, dynamic>)).toList();
  }

  Future<List<Review>> getReviews(int id) async{
    final NetworkHelper networkHelper = NetworkHelper(
      '$_baseUrlForReviewsOrVideos$id/reviews?api_key=$_apikey&language=$language',
    );
    final data = await networkHelper.getData();
    final Iterable results = await data['results'] as Iterable;
    return results.map((review) => Review.fromJson(review as Map<String,dynamic>)).toList();
  }


  Future<List<Video>> getVideos(int id) async{
    final NetworkHelper networkHelper = NetworkHelper(
        '$_baseUrlForReviewsOrVideos$id/videos?api_key=$_apikey',
    );

    final data = await networkHelper.getData();
    final Iterable results = await data['results'] as Iterable;
    return results.map((video) => Video.fromJson(video as Map<String,dynamic>)).toList();
  }
}
