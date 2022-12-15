// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, prefer_const_constructors, prefer_is_empty

import 'package:core/core.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchMovieBloc>().add(OnQueryEmpty());
    context.read<SearchTvBloc>().add(OnTvQueryEmpty());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: buildSearchTextField(context),
          bottom: buildTabBar(),
        ),
        body: TabBarView(children: [
          buildMovieSearch(),
          buildTvSearch(),
        ]),
      ),
    );
  }

  TextField buildSearchTextField(BuildContext context) {
    return TextField(
      controller: searchController,
      onSubmitted: (query) {
        context.read<SearchMovieBloc>().add(OnQueryChanged(query));
        context.read<SearchTvBloc>().add(OnTvQueryChanged(query));
      },
      decoration: InputDecoration(
        hintText: 'Search title',
      ),
      textInputAction: TextInputAction.search,
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      indicatorColor: kColorScheme.primary,
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

  BlocBuilder<SearchMovieBloc, SearchState> buildMovieSearch() {
    return BlocBuilder<SearchMovieBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchHasData) {
          final result = state.result;
          if (result.isEmpty) {
            return Center(
              child: Text(
                "The movie you're looking for couldn't be found",
                style: kBodyText,
              ),
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return EntertaimentCard(
                  movie: movie,
                  isTV: false,
                );
              },
              itemCount: result.length >= 1 ? result.length : 1);
        } else if (state is SearchError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }

  BlocBuilder<SearchTvBloc, SearchTVState> buildTvSearch() {
    return BlocBuilder<SearchTvBloc, SearchTVState>(
      builder: (context, state) {
        if (state is SearchTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchTvHasData) {
          final result = state.result;
          if (result.isEmpty) {
            return Center(
              child: Text(
                "The TV Show you're looking for couldn't be found",
                style: kBodyText,
              ),
            );
          }
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tv = state.result[index];
                return EntertaimentCard(
                  tv: tv,
                  isTV: true,
                );
              },
              itemCount: result.length >= 1 ? result.length : 1);
        } else if (state is SearchTvError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
