part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class SaveWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const SaveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class GetWatchlistMovieStatus extends WatchlistMovieEvent {
  final int idMovie;

  const GetWatchlistMovieStatus(this.idMovie);

  @override
  List<Object> get props => [idMovie];
}

class GetWatchlistMovie extends WatchlistMovieEvent {}
