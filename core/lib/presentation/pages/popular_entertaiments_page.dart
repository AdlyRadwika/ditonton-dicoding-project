// ignore_for_file: constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ? context.read<PopularTvBloc>().add(GetPopularTvEvent())
        : context.read<PopularMovieBloc>().add(GetPopularMovieEvent());
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
            ? buildPopularTvs()
            : buildPopularMovies(),
      ),
    );
  }

  BlocBuilder<PopularMovieBloc, PopularMovieState> buildPopularMovies() {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, state) {
        if (state is PopularMovieLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularMovieHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.popularMovie[index];
              return EntertaimentCard(isTV: false, movie: movie);
            },
            itemCount: state.popularMovie.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(state is PopularMovieError ? state.message : 'There is something wrong'),
          );
        }
      },
    );
  }

  BlocBuilder<PopularTvBloc, PopularTvState> buildPopularTvs() {
    return BlocBuilder<PopularTvBloc, PopularTvState>(
      builder: (context, state) {
        if (state is PopularTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularTvHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = state.popularTv[index];
              return EntertaimentCard(isTV: true, tv: tv);
            },
            itemCount: state.popularTv.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(state is PopularTvError ? state.message : 'There is something wrong'),
          );
        }
      },
    );
  }
}
