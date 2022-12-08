// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:core/utils/routes.dart';
import 'package:core/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies();
      Provider.of<TvListNotifier>(context, listen: false)
        ..fetchOnTheAirTVs()
        ..fetchPopularTvs()
        ..fetchTopRatedTvs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing Movies',
                onTap: () => Navigator.pushNamed(
                  context,
                  NOW_PLAYING_ROUTE,
                  arguments: false,
                ),
              ),
              buildMovieListConsumer(indexState: 0),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () => Navigator.pushNamed(
                  context,
                  POPULAR_ROUTE,
                  arguments: false,
                ),
              ),
              buildMovieListConsumer(indexState: 1),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () => Navigator.pushNamed(
                  context,
                  TOP_RATED_ROUTE,
                  arguments: false,
                ),
              ),
              buildMovieListConsumer(indexState: 2),
              _buildSubHeading(
                title: 'On The Air TV Shows',
                onTap: () => Navigator.pushNamed(
                  context,
                  NOW_PLAYING_ROUTE,
                  arguments: true,
                ),
              ),
              buildTvListConsumer(indexState: 0),
              _buildSubHeading(
                title: 'Popular TV Shows',
                onTap: () => Navigator.pushNamed(
                  context,
                  POPULAR_ROUTE,
                  arguments: true,
                ),
              ),
              buildTvListConsumer(indexState: 1),
              _buildSubHeading(
                title: 'Top Rated TV Shows',
                onTap: () => Navigator.pushNamed(
                  context,
                  TOP_RATED_ROUTE,
                  arguments: true,
                ),
              ),
              buildTvListConsumer(indexState: 2),
            ],
          ),
        ),
      ),
    );
  }

  Consumer<MovieListNotifier> buildMovieListConsumer(
      {required int indexState}) {
    return Consumer<MovieListNotifier>(builder: (context, data, child) {
      List<RequestState> state = [
        data.nowPlayingMoviesState,
        data.popularMoviesState,
        data.topRatedMoviesState
      ];
      List movies = [
        data.nowPlayingMovies,
        data.popularMovies,
        data.topRatedMovies
      ];
      if (state[indexState] == RequestState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state[indexState] == RequestState.Loaded) {
        return MovieList(movies: movies[indexState]);
      } else {
        return Text('Failed');
      }
    });
  }

  Consumer<TvListNotifier> buildTvListConsumer({required int indexState}) {
    return Consumer<TvListNotifier>(builder: (context, data, child) {
      List<RequestState> state = [
        data.onTheAirTVsState,
        data.popularTvsState,
        data.topRatedTvsState
      ];
      List tvs = [data.onTheAirTVs, data.popularTvs, data.topRatedTvs];
      if (state[indexState] == RequestState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state[indexState] == RequestState.Loaded) {
        return TvList(tvs: tvs[indexState]);
      } else {
        return Text('Failed');
      }
    });
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie>? movies;

  MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies![index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_ROUTE,
                  arguments:
                      EntertaimentDetailArguments(id: movie.id, isTV: false),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies!.length,
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv>? tvs;

  TvList({required this.tvs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs![index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_ROUTE,
                  arguments: EntertaimentDetailArguments(id: tv.id, isTV: true),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs!.length,
      ),
    );
  }
}

class EntertaimentDetailArguments {
  final int id;
  final bool isTV;

  const EntertaimentDetailArguments({required this.id, required this.isTV});
}
