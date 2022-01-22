import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/cubit/first_page_cubit.dart';
import 'package:movie_app/data/json_utils.dart';
import 'package:movie_app/presentation/screens/movie_detail.dart';
import 'package:movie_app/presentation/widgets/custom_snackbars.dart';
import 'package:movie_app/utilits/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isSwitched = false;
  Sorting sorting = Sorting.popularity;
  final RefreshController refreshController = RefreshController();

  void switchSelect({required bool value}) {
    setState(() {
      isSwitched = value;
      refreshController.requestRefresh();
      if(isSwitched){
        sorting = Sorting.topRated;
      }else{
        sorting= Sorting.popularity;
      }
    });
  }

  // Future<void> onRefresh() async {
  //   context
  //       .read<MovieBloc>()
  //       .add(MovieRefreshEvent(sortType: Sorting.popularity));
  //   refreshController.refreshCompleted();
  // }

  // Future<void> onLoading() async {
  //   context.read<MovieBloc>().add(MovieLoadEvent(sortType: Sorting.popularity));
  //   refreshController.loadComplete();
  // }

  @override
  void initState() {
    // BlocProvider.of<MovieBloc>(context)
    //     .add(MovieRefreshEvent(sortType: Sorting.popularity));
    
    BlocProvider.of<FirstPageCubit>(context).onRefresh(sortType: sorting);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieApp'),
        actions: [
          PopupMenuButton(itemBuilder: (context){
            return[
              const PopupMenuItem<int>(value: 0,child: Text('Delete'),),
              const PopupMenuItem<int>(value: 1,child: Text('Refresh'),),
            ];
          },
              onSelected:(value){
                if(value == 0){
                  BlocProvider.of<FirstPageCubit>(context).onDelete();
                }else if(value == 1) {
                  BlocProvider.of<FirstPageCubit>(context).onRefresh(sortType: sorting);
                }
              }),
        ],
      ),
      body: BlocConsumer<FirstPageCubit, FirstPageState>(
        listener: (context, state) {
          if (state is FirstPageError) {
            buildErrorCustomSnackBar(context, state.message);
          }

          if (state is FirstPageLoaded) {
            refreshController.refreshCompleted();
          }
        },
        builder: (context, state) {
          if (state is FirstPageEmpty) {
            return const Center(
              child: Text('Пока фильмов нету!'),
            );
          }

          if (state is FirstPageLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }

          if (state is FirstPageLoaded) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        switchSelect(value: false);
                        // getData(Sorting.popularity, 1);
                      },
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          color: (!isSwitched) ? Colors.purple : Colors.white,
                        ),
                      ),
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        switchSelect(value: value);
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        switchSelect(value: true);
                        // getData(Sorting.topRated, 1);
                      },
                      child: Text(
                        'Top Rated',
                        style: TextStyle(
                          color: isSwitched ? Colors.purple : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: true,
                    onRefresh: () async {
                      BlocProvider.of<FirstPageCubit>(context).onRefresh(sortType: sorting);
                    },
                    onLoading: () async {
                      BlocProvider.of<FirstPageCubit>(context).onLoading(sortType: sorting);
                      refreshController.loadComplete();
                    },
                    child: GridView.builder(
                      itemCount: state.movies.length,
                      // shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 185 / 278,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetail(movie: state.movies[index])));
                          },
                          child: SizedBox(
                            height: 150,
                            child: BlurHash(
                              hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                              image: '$kImageBaseUrl$kSmallPosterSize${state.movies[index].posterPath}',
                            ),
                          )
                          // Image.network(
                          //   '$kImageBaseUrl$kSmallPosterSize${state.movies[index].posterPath}',
                          //   fit: BoxFit.fill,
                          // ),
                        );
                      },
                    ), // MoviesWidget(movies: movies),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
