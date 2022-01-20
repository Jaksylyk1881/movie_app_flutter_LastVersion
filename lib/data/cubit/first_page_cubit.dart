import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/json_utils.dart';
import 'package:movie_app/data/model/movie.dart';

part 'first_page_state.dart';

class FirstPageCubit extends Cubit<FirstPageState> {
  FirstPageCubit() : super(FirstPageEmpty());
  int _currentPage = 1;
  List<Movie> _movies = [];

  Future<void> onRefresh({required Sorting sortType}) async {
    try {
      emit(FirstPageLoading());
      final data = await JsonUtils().getMovies(sortType, 1);
      log("getData:: $data, page:: $_currentPage");
      _movies = data;
      _currentPage++;
      emit(FirstPageLoaded(movies: _movies));
    } catch (e) {
      log('$e');
      emit(FirstPageError(message: '$e'));
    }
  }

  Future<void> onLoading({required Sorting sortType}) async {
    try {
      final data = await JsonUtils().getMovies(sortType, _currentPage);
      log("ONLOADING:: , page:: $_currentPage");
      _movies.addAll(data);
      _currentPage++;
      emit(FirstPageLoaded(movies: _movies));
    } catch (e) {
      log('$e');
      emit(FirstPageError(message: '$e'));
    }
  }
}
