import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tvs_notifier.dart';
import 'package:ditonton/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedEntertaimentsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated';

  final bool isTV;

  const TopRatedEntertaimentsPage({required this.isTV});

  @override
  _TopRatedEntertaimentsPageState createState() => _TopRatedEntertaimentsPageState();
}

class _TopRatedEntertaimentsPageState extends State<TopRatedEntertaimentsPage> {
  @override
  void initState() {
    super.initState();
    widget.isTV == true
    ? Future.microtask(() =>
        Provider.of<TopRatedTvsNotifier>(context, listen: false)
            .fetchTopRatedtvs())
    : Future.microtask(() =>
        Provider.of<TopRatedMoviesNotifier>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isTV == true ? 'Top Rated TV Shows' : 'Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.isTV == true ? buildTvConsumer() : buildMovieConsumer(),
      ),
    );
  }

  Consumer<TopRatedMoviesNotifier> buildMovieConsumer() {
    return Consumer<TopRatedMoviesNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.movies[index];
              return EntertaimentCard(movie: movie, isTV: false,);
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

  Consumer<TopRatedTvsNotifier> buildTvConsumer() {
    return Consumer<TopRatedTvsNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = data.tvs[index];
              return EntertaimentCard(tv: tv, isTV: true,);
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
