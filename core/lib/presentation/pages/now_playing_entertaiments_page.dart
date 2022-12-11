// ignore_for_file: constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors
import 'package:core/core.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        : context.read<NowPlayingMovieBloc>().add(GetNowPlayingMovieEvent());
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
            : buildMovie(),
      ),
    );
  }

  BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState> buildMovie() {
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
      builder: (context, data) {
        if (data is NowPlayingMovieLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data is NowPlayingMovieHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.nowPlayingMovie[index];
              return EntertaimentCard(isTV: false, movie: movie);
            },
            itemCount: data.nowPlayingMovie.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data is NowPlayingMovieError ? data.message : 'There is something wrong!'),
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