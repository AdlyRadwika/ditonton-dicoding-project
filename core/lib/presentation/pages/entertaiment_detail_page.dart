// ignore_for_file: constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_typing_uninitialized_variables, use_build_context_synchronously, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:core/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
            Provider.of<TvDetailNotifier>(context, listen: false)
                .fetchTvDetail(widget.id);
            Provider.of<TvDetailNotifier>(context, listen: false)
                .loadTvWatchlistStatus(widget.id);
          })
        : Future.microtask(() {
            Provider.of<MovieDetailNotifier>(context, listen: false)
                .fetchMovieDetail(widget.id);
            Provider.of<MovieDetailNotifier>(context, listen: false)
                .loadMovieWatchlistStatus(widget.id);
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isTV == true ? buildTvDetailBody() : buildMovieDetailBody(),
    );
  }

  Consumer<MovieDetailNotifier> buildMovieDetailBody() {
    return Consumer<MovieDetailNotifier>(
      builder: (context, provider, child) {
        if (provider.movieState == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.movieState == RequestState.Loaded) {
          final movie = provider.movie;
          return SafeArea(
            child: DetailContent(
              isTV: false,
              movie: movie,
              movieRecommendations: provider.movieRecommendations,
              isAddedWatchlist: provider.isAddedToMovieWatchlist,
            ),
          );
        } else {
          return Text(provider.message);
        }
      },
    );
  }
}

Consumer<TvDetailNotifier> buildTvDetailBody() {
  return Consumer<TvDetailNotifier>(
    builder: (context, provider, child) {
      if (provider.tvState == RequestState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (provider.tvState == RequestState.Loaded) {
        final tv = provider.tv;
        return SafeArea(
          child: DetailContent(
            isTV: true,
            tv: tv,
            tvRecommendations: provider.tvRecommendations,
            isAddedWatchlist: provider.isAddedToWatchlist,
          ),
        );
      } else {
        return Text(provider.message);
      }
    },
  );
}

class DetailContent extends StatelessWidget {
  final MovieDetail? movie;
  final TvDetail? tv;
  final bool isTV;
  final List<Movie>? movieRecommendations;
  final List<Tv>? tvRecommendations;
  final bool isAddedWatchlist;

  DetailContent(
      {this.movie,
      this.movieRecommendations,
      this.tvRecommendations,
      required this.isAddedWatchlist,
      this.tv,
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
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  isTV == true
                                      ? await Provider.of<TvDetailNotifier>(
                                              context,
                                              listen: false)
                                          .addTvWatchlist(tv!)
                                      : await Provider.of<MovieDetailNotifier>(
                                              context,
                                              listen: false)
                                          .addMovieWatchlist(movie!);
                                } else {
                                  isTV == true
                                      ? await Provider.of<TvDetailNotifier>(
                                              context,
                                              listen: false)
                                          .removeFromTvWatchlist(tv!)
                                      : await Provider.of<MovieDetailNotifier>(
                                              context,
                                              listen: false)
                                          .removeFromMovieWatchlist(movie!);
                                }

                                var message;

                                isTV == true
                                    ? message = Provider.of<TvDetailNotifier>(
                                            context,
                                            listen: false)
                                        .watchlistMessage
                                    : message =
                                        Provider.of<MovieDetailNotifier>(
                                                context,
                                                listen: false)
                                            .watchlistMessage;

                                if (message ==
                                        MovieDetailNotifier
                                            .movieWatchlistAddSuccessMessage ||
                                    message ==
                                        MovieDetailNotifier
                                            .movieWatchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else if (message ==
                                        TvDetailNotifier
                                            .tvWatchlistAddSuccessMessage ||
                                    message ==
                                        TvDetailNotifier
                                            .tvWatchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
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

  Consumer<MovieDetailNotifier> buildMovieRecommendations() {
    return Consumer<MovieDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.recommendationState == RequestState.Error) {
          return Text(data.message);
        } else if (data.recommendationState == RequestState.Loaded) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movieRecommendations![index];
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
              itemCount: movieRecommendations!.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Consumer<TvDetailNotifier> buildTvRecommendations() {
    return Consumer<TvDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.recommendationState == RequestState.Error) {
          return Text(data.message);
        } else if (data.recommendationState == RequestState.Loaded) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tv = tvRecommendations![index];
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
              itemCount: tvRecommendations!.length,
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
