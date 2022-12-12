// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(GetNowPlayingMovieEvent());
      context.read<PopularMovieBloc>().add(GetPopularMovieEvent());
      context.read<TopRatedMovieBloc>().add(GetTopRatedMovieEvent());
      context.read<NowPlayingTvBloc>().add(GetNowPlayingTvEvent());
      context.read<PopularTvBloc>().add(GetPopularTvEvent());
      context.read<TopRatedTvBloc>().add(GetTopRatedTvEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_ROUTE);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing Movies',
                onTap: () => Navigator.pushNamed(
                  context,
                  NOW_PLAYING_ROUTE,
                  arguments: false,
                ),
              ),
              buildMovieList(blocIndex: 0),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () => Navigator.pushNamed(
                  context,
                  POPULAR_ROUTE,
                  arguments: false,
                ),
              ),
              buildMovieList(blocIndex: 1),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () => Navigator.pushNamed(
                  context,
                  TOP_RATED_ROUTE,
                  arguments: false,
                ),
              ),
              buildMovieList(blocIndex: 2),
              _buildSubHeading(
                title: 'On The Air TV Shows',
                onTap: () => Navigator.pushNamed(
                  context,
                  NOW_PLAYING_ROUTE,
                  arguments: true,
                ),
              ),
              buildTvList(blocIndex: 0),
              _buildSubHeading(
                title: 'Popular TV Shows',
                onTap: () => Navigator.pushNamed(
                  context,
                  POPULAR_ROUTE,
                  arguments: true,
                ),
              ),
              buildTvList(blocIndex: 1),
              _buildSubHeading(
                title: 'Top Rated TV Shows',
                onTap: () => Navigator.pushNamed(
                  context,
                  TOP_RATED_ROUTE,
                  arguments: true,
                ),
              ),
              buildTvList(blocIndex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMovieList({required int blocIndex}) {
    if (blocIndex == 0) {
      return BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
          builder: (context, state) {
        if (state is NowPlayingMovieLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NowPlayingMovieHasData) {
          return MovieList(movies: state.nowPlayingMovie);
        } else {
          return Text('Failed');
        }
      });
    }
    if (blocIndex == 1) {
      return BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
        if (state is PopularMovieLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularMovieHasData) {
          return MovieList(movies: state.popularMovie);
        } else {
          return Text('Failed');
        }
      });
    }
    if (blocIndex == 2) {
      return BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
        if (state is TopRatedMovieLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopRatedMovieHasData) {
          return MovieList(movies: state.topRatedMovie);
        } else {
          return Text('Failed');
        }
      });
    }
    return Center(
      child: Text('Movie list not found'),
    );
  }

  Widget buildTvList({required int blocIndex}) {
    if (blocIndex == 0) {
      return BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
          builder: (context, state) {
        if (state is NowPlayingTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NowPlayingTvHasData) {
          return TvList(tvs: state.nowPlayingTv);
        } else {
          return Text('Failed');
        }
      });
    }
    if (blocIndex == 1) {
      return BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
        if (state is PopularTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularTvHasData) {
          return TvList(tvs: state.popularTv);
        } else {
          return Text('Failed');
        }
      });
    }
    if (blocIndex == 2) {
      return BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
        if (state is TopRatedTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopRatedTvHasData) {
          return TvList(tvs: state.topRatedTv);
        } else {
          return Text('Failed');
        }
      });
    }
    return Center(
      child: Text('Tv list not found'),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie>? movies;

  MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies![index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_ROUTE,
                  arguments:
                      EntertaimentDetailArguments(id: movie.id, isTV: false),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies!.length,
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv>? tvs;

  TvList({required this.tvs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs![index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_ROUTE,
                  arguments: EntertaimentDetailArguments(id: tv.id, isTV: true),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs!.length,
      ),
    );
  }
}

class EntertaimentDetailArguments {
  final int id;
  final bool isTV;

  const EntertaimentDetailArguments({required this.id, required this.isTV});
}
