// ignore_for_file: constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors
import 'package:core/core.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingEntertaimentsPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing';

  final bool isTV;

  NowPlayingEntertaimentsPage({required this.isTV});

  @override
  _NowPlayingEntertaimentsPageState createState() =>
      _NowPlayingEntertaimentsPageState();
}

class _NowPlayingEntertaimentsPageState extends State<NowPlayingEntertaimentsPage> {
  @override
  void initState() {
    super.initState();
    widget.isTV == true
        ? Future.microtask(() =>
            Provider.of<TvListNotifier>(context, listen: false)
                .fetchOnTheAirTVs())
        : Future.microtask(() =>
            Provider.of<MovieListNotifier>(context, listen: false)
                .fetchNowPlayingMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isTV == true ? 'On The Air TV Shows' : 'Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.isTV == true
            ? buildTVConsumer()
            : buildMovieConsumer(),
      ),
    );
  }

  Consumer<MovieListNotifier> buildMovieConsumer() {
    return Consumer<MovieListNotifier>(
      builder: (context, data, child) {
        if (data.nowPlayingMoviesState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.nowPlayingMoviesState == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.nowPlayingMovies[index];
              return EntertaimentCard(isTV: false, movie: movie);
            },
            itemCount: data.nowPlayingMovies.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }

  Consumer<TvListNotifier> buildTVConsumer() {
    return Consumer<TvListNotifier>(
      builder: (context, data, child) {
        if (data.onTheAirTVsState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.onTheAirTVsState == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = data.onTheAirTVs[index];
              return EntertaimentCard(
                tv: tv,
                isTV: true,
              );
            },
            itemCount: data.onTheAirTVs.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }
}
