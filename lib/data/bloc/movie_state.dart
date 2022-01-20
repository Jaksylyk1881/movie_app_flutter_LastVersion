
import 'package:movie_app/data/model/movie.dart';

abstract class MovieState {}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  List<Movie> movies;
  MovieLoaded({required this.movies});
}

class MovieError extends MovieState {
  String message;
  MovieError({required this.message});
}
