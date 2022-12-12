// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedEntertaimentsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated';

  final bool isTV;

  const TopRatedEntertaimentsPage({required this.isTV});

  @override
  _TopRatedEntertaimentsPageState createState() =>
      _TopRatedEntertaimentsPageState();
}

class _TopRatedEntertaimentsPageState extends State<TopRatedEntertaimentsPage> {
  @override
  void initState() {
    super.initState();
    widget.isTV == true
        ? context.read<TopRatedTvBloc>().add(GetTopRatedTvEvent())
        : context.read<TopRatedMovieBloc>().add(GetTopRatedMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isTV == true ? 'Top Rated TV Shows' : 'Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.isTV == true ? buildTv() : buildMovie(),
      ),
    );
  }

  BlocBuilder<TopRatedMovieBloc, TopRatedMovieState> buildMovie() {
    return BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
      builder: (context, state) {
        if (state is TopRatedMovieLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopRatedMovieHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.topRatedMovie[index];
              return EntertaimentCard(
                movie: movie,
                isTV: false,
              );
            },
            itemCount: state.topRatedMovie.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(state is TopRatedMovieError
                ? state.message
                : 'There is something wrong'),
          );
        }
      },
    );
  }

  BlocBuilder<TopRatedTvBloc, TopRatedTvState> buildTv() {
    return BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
      builder: (context, state) {
        if (state is TopRatedTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopRatedTvHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = state.topRatedTv[index];
              return EntertaimentCard(
                tv: tv,
                isTV: false,
              );
            },
            itemCount: state.topRatedTv.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(state is TopRatedTvError
                ? state.message
                : 'There is something wrong'),
          );
        }
      },
    );
  }
}
