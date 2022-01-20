import 'package:movie_app/data/json_utils.dart';
import 'package:movie_app/data/model/movie.dart';

abstract class MovieEvent {}

class MovieLoadEvent extends MovieEvent {
  Sorting sortType;
  bool isRefresh;
  MovieLoadEvent({
    required this.sortType,
    this.isRefresh = false,
  });
}

class MovieRefreshEvent extends MovieEvent {
  Sorting sortType;
  MovieRefreshEvent({
    required this.sortType,
  });
}
