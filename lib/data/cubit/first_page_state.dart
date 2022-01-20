part of 'first_page_cubit.dart';

abstract class FirstPageState {}

class FirstPageInitial extends FirstPageState {}

class FirstPageLoading extends FirstPageState {}

class FirstPageLoaded extends FirstPageState {
  List<Movie> movies;
  FirstPageLoaded({required this.movies});
}

class FirstPageError extends FirstPageState {
  String message;
  FirstPageError({required this.message});
}
