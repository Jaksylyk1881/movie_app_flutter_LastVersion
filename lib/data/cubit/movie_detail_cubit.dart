import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/json_utils.dart';
import 'package:movie_app/data/model/review.dart';
import 'package:movie_app/data/model/video.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState>{
  MovieDetailCubit() : super(MovieDetailEmpty());

  Future<void> onLoadingReviewsAndVideos({required int id})async{
    try{
      emit(MovieDetailLoading());
      final data = await JsonUtils().getReviews(id);
      final List<Review> reviews = data;
      final data1 = await JsonUtils().getVideos(id);
      final List<Video> videos = data1;
      emit(MovieDetailLoaded(reviews: reviews, videos: videos));
    }catch(e){
      emit(MovieDetailError(message: '$e'));
    }
  }

}