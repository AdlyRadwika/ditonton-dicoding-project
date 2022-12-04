// ignore_for_file: constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import '../../utils/state_enum.dart';
import 'package:core/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:core/presentation/provider/tv/popular_tvs_notifier.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularEntertaimentsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-entertaiment';

  final bool isTV;

  PopularEntertaimentsPage({required this.isTV});

  @override
  _PopularEntertaimentsPageState createState() =>
      _PopularEntertaimentsPageState();
}

class _PopularEntertaimentsPageState extends State<PopularEntertaimentsPage> {
  @override
  void initState() {
    super.initState();
    widget.isTV == true
        ? Future.microtask(() =>
            Provider.of<PopularTvsNotifier>(context, listen: false)
                .fetchPopularTvs())
        : Future.microtask(() =>
            Provider.of<PopularMoviesNotifier>(context, listen: false)
                .fetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isTV == true ? 'Popular TV Shows' : 'Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.isTV == true
            ? buildPopularTvsConsumer()
            : buildPopularMoviesConsumer(),
      ),
    );
  }

  Consumer<PopularMoviesNotifier> buildPopularMoviesConsumer() {
    return Consumer<PopularMoviesNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.movies[index];
              return EntertaimentCard(isTV: false, movie: movie);
            },
            itemCount: data.movies.length,
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

  Consumer<PopularTvsNotifier> buildPopularTvsConsumer() {
    return Consumer<PopularTvsNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = data.tvs[index];
              return EntertaimentCard(
                tv: tv,
                isTV: true,
              );
            },
            itemCount: data.tvs.length,
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
