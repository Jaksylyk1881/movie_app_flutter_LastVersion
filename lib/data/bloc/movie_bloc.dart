import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/bloc/movie_event.dart';
import 'package:movie_app/data/bloc/movie_state.dart';
import 'package:movie_app/data/json_utils.dart';
import 'package:movie_app/data/model/movie.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  int _currentPage = 1;
  List<Movie> _movies = [];

  MovieBloc(MovieState initialState) : super(initialState) {
    on<MovieLoadEvent>((event, emit) async {
      try {
        // emit(MovieLoading());
        final data = await JsonUtils().getMovies(event.sortType, _currentPage);
        log("ONLOADING:: , page:: $_currentPage");
        _movies.addAll(data);
        _currentPage++;
        emit(MovieLoaded(movies: _movies));
      } catch (e) {
        log('$e');
        emit(MovieError(message: '$e'));
      }
    });
    on<MovieRefreshEvent>((event, emit) async {
      try {
        emit(MovieLoading());
        final data = await JsonUtils().getMovies(event.sortType, 1);
        log("getData:: $data, page:: $_currentPage");
        _movies = data;
        _currentPage++;
        emit(MovieLoaded(movies: _movies));
      } catch (e) {
        log('$e');
        emit(MovieError(message: '$e'));
      }
    });
  }
}
