import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlistTvNotifier>(context, listen: false)
            .fetchWatchlistTvs());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false)
        .fetchWatchlistTvs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Movies Watchlist',
              style: kHeading6,
            ),
            buildMovieConsumer(),
            Text(
              'TV Shows Watchlist',
              style: kHeading6,
            ),
            buildTvConsumer(),
          ],
        ),
      ),
    );
  }

  Consumer<WatchlistMovieNotifier> buildMovieConsumer() {
    return Consumer<WatchlistMovieNotifier>(
      builder: (context, movieData,child) {
        if (movieData.watchlistState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (movieData.watchlistState == RequestState.Loaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: movieData.watchlistMovies.length,
              itemBuilder: (context, index) {
                final movie = movieData.watchlistMovies[index];
                return EntertaimentCard(movie: movie, isTV: false,);
              },
            ),
          );
        } else {
          return Expanded(
            child: Center(
              key: Key('error_message'),
              child: Text("${movieData.message}"),
            ),
          );
        }
      },
    );
  }

  Consumer<WatchlistTvNotifier> buildTvConsumer() {
    return Consumer<WatchlistTvNotifier>(
      builder: (context, tvData,child) {
        if (tvData.watchlistState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (tvData.watchlistState == RequestState.Loaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: tvData.watchlistTvs.length,
              itemBuilder: (context, index) {
                final tv = tvData.watchlistTvs[index];
                return EntertaimentCard(tv: tv, isTV: true,);
              },
            ),
          );
        } else {
          return Expanded(
            child: Center(
              key: Key('error_message'),
              child: Text("${tvData.message}"),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
