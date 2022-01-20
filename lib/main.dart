import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/bloc/movie_bloc.dart';
import 'package:movie_app/data/bloc/movie_state.dart';
import 'package:movie_app/data/cubit/first_page_cubit.dart';
import 'package:movie_app/presentation/screens/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(MovieEmpty()),
        ),
        BlocProvider<FirstPageCubit>(create: (context) => FirstPageCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            color: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const FirstPage(),
      ),
    );
  }
}
