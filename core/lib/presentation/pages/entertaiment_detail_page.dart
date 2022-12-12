// ignore_for_file: constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_typing_uninitialized_variables, use_build_context_synchronously, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EntertaimentDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  final bool isTV;
  EntertaimentDetailPage({required this.id, required this.isTV});

  @override
  _EntertaimentDetailPageState createState() => _EntertaimentDetailPageState();
}

class _EntertaimentDetailPageState extends State<EntertaimentDetailPage> {
  @override
  void initState() {
    super.initState();
    widget.isTV == true
        ? Future.microtask(() {
            context.read<TvDetailBloc>().add(GetTvDetailEvent(widget.id));
            context.read<RecommendationTvsBloc>().add(GetRecommendationTvEvent(widget.id));
            context.read<WatchlistTvBloc>().add(GetWatchlistTvStatus(widget.id));
          })
        : Future.microtask(() {
            context.read<MovieDetailBloc>().add(GetMovieDetailEvent(widget.id));
            context.read<RecommendationMoviesBloc>().add(GetRecommendationMovieEvent(widget.id));
            context.read<WatchlistMovieBloc>().add(GetWatchlistMovieStatus(widget.id));
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isTV == true 
        ? buildTvDetailBody()
        : buildMovieDetailBody(),
    );
  }

BlocBuilder<MovieDetailBloc, MovieDetailState> buildMovieDetailBody() {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailData) {
          final movie = state.movieDetail;
          return BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
            builder: (context, state) {
              bool isAdded = state is GetWatchlistMovieStatusData ? state.isAddedWatchlist : false;
              return SafeArea(
                child: DetailContent(
                  isTV: false,
                  movie: movie,
                  isAddedToWatchlist: isAdded,
                ),
              );
            },
          );
        } else {
          return state is MovieDetailError 
            ? Center(child: Text(state.message)) 
            : Center(child: Text('There is something wrong'));
        } 
      },
    );
  }
}

BlocBuilder<TvDetailBloc, TvDetailState> buildTvDetailBody() {
  return BlocBuilder<TvDetailBloc, TvDetailState>(
    builder: (context, state) {
      if (state is TvDetailLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TvDetailData) {
        final tv = state.tvDetail;
        return BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            bool isAdded = state is GetWatchlistTvStatusData ? state.isAddedWatchlist : false;
            return SafeArea(
              child: DetailContent(
                isTV: true,
                tv: tv,
                isAddedToWatchlist: isAdded,
              ),
            );
          },
        );
      } else {
        return state is TvDetailError 
          ? Center(child: Text(state.message)) 
          : Center(child: Text('There is something wrong'));
      }
    },
  );
}

class DetailContent extends StatelessWidget {
  final MovieDetail? movie;
  final TvDetail? tv;
  final bool isAddedToWatchlist;
  final bool isTV;

  DetailContent(
      {this.movie,
      this.tv,
      required this.isAddedToWatchlist,
      required this.isTV});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${isTV == true ? tv?.posterPath : movie?.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isTV == true ? tv!.name : movie!.title,
                              style: kHeading5,
                            ),
                            isTV == true 
                              ? _buildWatchlistTvButton() 
                              : _buildWatchlistMovieButton(),
                            Text(
                              _showGenres(
                                  isTV == true ? tv!.genres : movie!.genres),
                            ),
                            Text(
                              isTV == true
                                  ? "${tv!.numberOfEpisodes} episodes, ${tv!.numberOfSeasons} seasons"
                                  : _showDuration(movie!.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: isTV == true
                                      ? tv!.voteAverage
                                      : movie!.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text(
                                    '${isTV == true ? tv!.voteAverage : movie!.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              isTV == true ? tv!.overview : movie!.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            isTV == true
                                ? buildTvRecommendations()
                                : buildMovieRecommendations(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  BlocBuilder<WatchlistTvBloc, WatchlistTvState> _buildWatchlistTvButton() {
    return BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (state is GetWatchlistTvStatusData) {
              if (!state.isAddedWatchlist) {
                context.read<WatchlistTvBloc>().add(SaveWatchlistTv(tv!));
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Added to Tv watchlist')));
              } else {
                context.read<WatchlistTvBloc>().add(RemoveWatchlistTv(tv!));
                context.read<WatchlistTvBloc>().add(GetWatchlistTvStatus(tv!.id));
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Removed from Tv watchlist')));
              }
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isAddedToWatchlist == true
              ? Icon(Icons.check)
              : Icon(Icons.add),
              Text('Watchlist'),
            ],
          )
        );
      },
    );
  }

  BlocBuilder<WatchlistMovieBloc, WatchlistMovieState> _buildWatchlistMovieButton() {
    return BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (state is GetWatchlistMovieStatusData) {
              if (!state.isAddedWatchlist) {
                context.read<WatchlistMovieBloc>().add(SaveWatchlistMovie(movie!));
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Added to movie watchlist')));
              } else {
                context.read<WatchlistMovieBloc>().add(RemoveWatchlistMovie(movie!));
                context.read<WatchlistMovieBloc>().add(GetWatchlistMovieStatus(movie!.id));
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Removed from movie watchlist')));
              }
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isAddedToWatchlist == true
              ? Icon(Icons.check)
              : Icon(Icons.add),
              Text('Watchlist'),
            ],
          )
        );
      },
    );
  }

  BlocBuilder<RecommendationMoviesBloc, RecommendationMoviesState> buildMovieRecommendations() {
    return BlocBuilder<RecommendationMoviesBloc, RecommendationMoviesState>(
      builder: (context, data) {
        if (data is RecommendationMoviesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data is RecommendationMoviesError) {
          return Text(data.message);
        } else if (data is RecommendationMoviesData) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = data.recommendationMovies[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        DETAIL_ROUTE,
                        arguments: EntertaimentDetailArguments(
                            id: movie.id, isTV: false),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: data.recommendationMovies.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  BlocBuilder<RecommendationTvsBloc, RecommendationTvsState> buildTvRecommendations() {
    return BlocBuilder<RecommendationTvsBloc, RecommendationTvsState>(
      builder: (context, state) {
        if (state is RecommendationTvsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RecommendationTvsError) {
          return Text(state.message);
        } else if (state is RecommendationTvsData) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tv = state.recommendationTvs[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        DETAIL_ROUTE,
                        arguments:
                            EntertaimentDetailArguments(id: tv.id, isTV: true),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.recommendationTvs.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
