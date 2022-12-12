// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, library_private_types_in_public_api, annotate_overrides, prefer_const_constructors, unnecessary_string_interpolations

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/utils.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';

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
      context.read<WatchlistMovieBloc>().add(GetWatchlistMovie()));
    Future.microtask(() =>
      context.read<WatchlistTvBloc>().add(GetWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(GetWatchlistMovie());
    context.read<WatchlistTvBloc>().add(GetWatchlistTv());
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
            buildMovie(),
            buildTv(),
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

  BlocBuilder<WatchlistMovieBloc, WatchlistMovieState> buildMovie() {
    return BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
      builder: (context, state) {
        if (state is GetWatchlistMovieLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetWatchlistMovieHasData) {
          return ListView.builder(
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return EntertaimentCard(movie: movie, isTV: false,);
            },
          );
        } else if (state is GetWatchlistMovieError) {
          return Center(
            key: Key('error_message'),
            child: Text("${state.message}"),
          );
        }else {
          return const Text('There is something wrong.');
        }
      },
    );
  }

  BlocBuilder<WatchlistTvBloc, WatchlistTvState> buildTv() {
    return BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
      builder: (context, state) {
        if (state is GetWatchlistTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetWatchlistTvHasData) {
          return ListView.builder(
            itemCount: state.tvs.length,
            itemBuilder: (context, index) {
              final tv = state.tvs[index];
              return EntertaimentCard(tv: tv, isTV: true,);
            },
          );
        } else if (state is GetWatchlistTvError) {
          return Center(
            key: Key('error_message'),
            child: Text("${state.message}"),
          );
        }else {
          return const Text('There is something wrong.');
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
