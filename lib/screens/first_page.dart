import 'package:flutter/material.dart';
import 'package:movie_app/data/json_utils.dart';
import 'package:movie_app/data/movie.dart';
import 'package:movie_app/widgets/movies_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  JsonUtils jsonUtils = JsonUtils();
  List<Movie> movies = [];
  bool isSwitched = false;
  int currentPage = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  void switchSelect(bool value) {
    setState(() {
      isSwitched = value;
    });
  }

  Future<bool> getData({required Sorting sortType, bool isRefresh = false,}) async {
    if(isRefresh){
      currentPage = 1 ;
    }else{
      
    }
    try {
      var data = await jsonUtils.getMovies(sortType, currentPage);
      setState(() {
        if(isRefresh){
          movies = data;
        }else{
          movies.addAll(data);
        }
        currentPage++;
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieApp'),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: ()async{
          final result = await getData(sortType: Sorting.popularity,isRefresh: true);
          if(result){
            refreshController.refreshCompleted();
          }else{
            refreshController.refreshFailed();
          }
        },
        onLoading: ()async{
          final result = await getData(sortType: Sorting.popularity);
          if(result){
            refreshController.loadComplete();
          }else{
            refreshController.loadFailed();
          }
        },

        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        switchSelect(false);
                        // getData(Sorting.popularity, 1);
                      },
                      child: Text(
                        'Popular',
                        style: TextStyle(
                            color: (!isSwitched) ? Colors.purple : Colors.white),
                      )),
                  Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        switchSelect(value);
                      }),
                  GestureDetector(
                      onTap: () {
                        switchSelect(true);
                        // getData(Sorting.topRated, 1);
                      },
                      child: Text(
                        'Top Rated',
                        style: TextStyle(
                            color: (isSwitched) ? Colors.purple : Colors.white),
                      )),
                ],
              ),
              Expanded(
                child: MoviesWidget(movies: movies),
              )
            ],
          ),
        ),
      ),
    );
  }
}
