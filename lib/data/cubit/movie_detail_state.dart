part of 'movie_detail_cubit.dart';

abstract class MovieDetailState{}

class MovieDetailEmpty extends MovieDetailState{}

class MovieDetailLoading extends MovieDetailState{}

class MovieDetailLoaded extends MovieDetailState{
  List<Review> reviews;
  List<Video> videos;

  MovieDetailLoaded({required this.reviews, required this.videos});

}

class MovieDetailError extends MovieDetailState{
  String message;

  MovieDetailError({required this.message});
}
