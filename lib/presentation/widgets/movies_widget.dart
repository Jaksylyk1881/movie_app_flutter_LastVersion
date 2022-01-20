import 'package:flutter/material.dart';
import 'package:movie_app/data/movie.dart';
import 'package:movie_app/utilits/constants.dart';

class MoviesWidget extends StatelessWidget {
  final List<Movie> movies;

  const MoviesWidget({required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movies.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 185 / 278,
      ),
      itemBuilder: (context, index) {
        return Image.network(
          '$kImageBaseUrl$kSmallPosterSize${movies[index].posterPath}',
          fit: BoxFit.fill,
        );
      },
    );
  }
}
