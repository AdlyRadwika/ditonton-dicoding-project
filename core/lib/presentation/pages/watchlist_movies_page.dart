// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, library_private_types_in_public_api, annotate_overrides, prefer_const_constructors, unnecessary_string_interpolations

import 'package:core/core.dart';
import '../../utils/utils.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: buildTabBar(),
        ),
        body: TabBarView(
          children: [
            buildMovieConsumer(),
            buildTvConsumer(),
          ],
        ),
      ),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      indicatorColor: kColorScheme.primary,
      // ignore: prefer_const_literals_to_create_immutables
      tabs: [
        Tab(
          icon: Icon(
            Icons.movie,
          ),
          text: 'Movies',
        ),
        Tab(
          icon: Icon(
            Icons.tv,
          ),
          text: 'TV Shows',
        ),
      ],
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
