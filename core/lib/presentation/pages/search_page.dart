// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, prefer_const_constructors, prefer_is_empty

import 'package:core/core.dart';
import 'package:core/presentation/widgets/entertaiment_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Provider.of<MovieSearchNotifier>(context, listen: false).emptyMovieSearch();
    Provider.of<TvSearchNotifier>(context, listen: false).emptyTvSearch();
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
        body: TabBarView(
          children: [
            buildMovieSearchConsumer(),
            buildTvSearchConsumer(),
          ]
        ),
      ),
    );
  }

  TextField buildSearchTextField(BuildContext context) {
    return TextField(
      controller: searchController,
      onSubmitted: (query) {
        Provider.of<MovieSearchNotifier>(context, listen: false)
            .fetchMovieSearch(query);
        Provider.of<TvSearchNotifier>(context, listen: false)
            .fetchTvSearch(query);
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

  Consumer<MovieSearchNotifier> buildMovieSearchConsumer() {
    return Consumer<MovieSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
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
                final movie = data.searchResult[index];
                return EntertaimentCard(
                  movie: movie,
                  isTV: false,
                );
              },
              itemCount: result.length >= 1 ? result.length : 1);
        } else {
          return Container();
        }
      },
    );
  }

  Consumer<TvSearchNotifier> buildTvSearchConsumer() {
    return Consumer<TvSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Loaded) {
          final result = data.searchResult;
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
                final tv = data.searchResult[index];
                return EntertaimentCard(
                  tv: tv,
                  isTV: true,
                );
              },
              itemCount: result.length >= 1 ? result.length : 1);
        } else {
          return Expanded(
            child: Container(),
          );
        }
      },
    );
  }
}
