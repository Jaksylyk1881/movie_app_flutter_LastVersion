import 'package:flutter/material.dart';
import 'package:movie_app/data/movie.dart';
import 'package:movie_app/utilits/constants.dart';

class MoviesWidget extends StatelessWidget {
  final List<Movie> movies;

  MoviesWidget({required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 185 / 278),
        itemBuilder: (context, index) {
          return Image.network(
            '$kImageBaseUrl$kSmallPosterSize${movies[index].posterPath}',
            fit: BoxFit.fill,
          );
        });
  }
}
