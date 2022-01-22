import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:movie_app/data/cubit/movie_detail_cubit.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/presentation/widgets/custom_snackbars.dart';
import 'package:movie_app/presentation/widgets/horizontal_line.dart';
import 'package:movie_app/presentation/widgets/info_text.dart';
import 'package:movie_app/utilits/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MovieDetail extends StatefulWidget {
  final Movie movie;
  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  List<Movie>? movies = [];
  late SharedPreferences prefs;
 late Movie movie;
 bool isFav = false;

 Future<void> getSharedPreference() async {
   prefs = await SharedPreferences.getInstance();
   final Iterable musicsString = prefs.getString('fav_movies') ;
   if(musicsString!=null){
     movies = Movie.decode(musicsString);
     for(Movie m in movies!){
       if(m.id==movie.id){
         isFav=true;
         break;
       }
     }
   }
 }

  @override
   void initState()  {
    super.initState();
    movie = widget.movie;
    BlocProvider.of<MovieDetailCubit>(context).onLoadingReviewsAndVideos(id: movie.id);
    getSharedPreference();

  }


  @override
  void dispose() {
    super.dispose();
    final String encodedData = Movie.encode(movies!);
    prefs.setString('fav_movies', encodedData);
  }

  void addToFav(){
    if(isFav){
      int idOfRemovingItem=0;
      for(int i = 0; i<movies!.length; i++){
        if(movies![i].id==movie.id){
          idOfRemovingItem = i;
          break;
        }
      }
      movies!.removeAt(idOfRemovingItem);
      isFav = false;
      log("Deleted");
    }else{
      isFav = true;
      movies?.add(movie);
      log("added");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children:  [
              Container(
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30)),
                  child: Container(
                    color: Colors.black,
                    child: SizedBox(
                      height: 550,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        child: BlurHash(
                          hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                          image: '$kImageBaseUrl$kBigPosterSize${movie.posterPath}',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(movie.title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),textAlign: TextAlign.center,),
                  Positioned(
                     bottom: 25,
                   right: 25,
                     child: GestureDetector(onTap:(){
                       setState(() {
                         addToFav();
                       });
                     },child: Icon(Icons.favorite, size: 80,color: isFav?Colors.red:Colors.grey,)),
                 ),
            ],),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InfoText(label: 'Название',info: movie.title,),const HorizontalLine(),
                  InfoText(label: 'Оргинальное \nназвание',info: movie.originalTitle,),const HorizontalLine(),
                  InfoText(label: 'Рейтинг',info: movie.voteAverage.toString(),),const HorizontalLine(),
                  InfoText(label: 'Дата релиза',info: movie.releaseDate,),const HorizontalLine(),
                  const InfoText(label: 'Описание',info: '',),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(movie.overview,style: kMainTextStyle,),
                  )
                ],
              ),
            ),
            BlocConsumer<MovieDetailCubit,MovieDetailState>(
              listener: (context, state){
                if (state is MovieDetailError) {
                  buildErrorCustomSnackBar(context, state.message);
                }
              },
              builder: (context,state){
                if(state is MovieDetailEmpty){
                  return const Center(
                    child: Text('Пока видео нету!'),
                  );
                }
                if(state is MovieDetailLoading){
                  return const Center(
                      child: CircularProgressIndicator(
                      color: Colors.purple,
                  ),
                  );
                }
                if(state is MovieDetailLoaded){
                  return Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.white70,
                              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: ListTile(
                                leading: const Icon(Icons.play_arrow,color: Colors.black,size: 30,),
                                title: Text(state.videos[index].name,style: const TextStyle(color: Colors.grey, fontSize: 20),),
                              ),
                            );
                          },
                            itemCount: state.videos.length,
                          ),
                        ),
                        Flexible(child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index){
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 150,top: 8,bottom: 8),
                                    child: Text(state.reviews[index].author,style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(state.reviews[index].content,style: const TextStyle(color: Colors.grey,fontSize: 16,),),
                                  ),
                                  HorizontalLine()
                                ],
                              );
                            },
                          itemCount: state.reviews.length,
                        ),
                        )
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              },
            )

          ],
        ),
      ),
    );
  }
}



