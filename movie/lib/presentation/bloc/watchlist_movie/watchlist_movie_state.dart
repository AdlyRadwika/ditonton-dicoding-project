part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class SaveWatchlistMovieLoading extends WatchlistMovieState {}

class SaveWatchlistMovieSuccess extends WatchlistMovieState {
  final String movieData;

  const SaveWatchlistMovieSuccess(this.movieData);

  @override
  List<Object> get props => [movieData];
}

class SaveWatchlistMovieError extends WatchlistMovieState {
  final String message;

  const SaveWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveWatchlistMovieLoading extends WatchlistMovieState {}

class RemoveWatchlistMovieSuccess extends WatchlistMovieState {
  final String movieData;

  const RemoveWatchlistMovieSuccess(this.movieData);

  @override
  List<Object> get props => [movieData];
}

class RemoveWatchlistMovieError extends WatchlistMovieState {
  final String message;

  const RemoveWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

abstract class GetWatchlistMovieStatusState extends Equatable {
  const GetWatchlistMovieStatusState();

  @override
  List<Object> get props => [];
}

class GetWatchlistMovieStatusInitial extends WatchlistMovieState {}

class GetWatchlistMovieStatusLoading extends WatchlistMovieState {}

class GetWatchlistMovieStatusData extends WatchlistMovieState {
  final bool isAddedWatchlist;

  const GetWatchlistMovieStatusData(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}

class GetWatchlistMovieStatusError extends WatchlistMovieState {
  final String message;

  const GetWatchlistMovieStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class GetWatchlistMovieLoading extends WatchlistMovieState {}

class GetWatchlistMovieEmpty extends WatchlistMovieState {}

class GetWatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> movies;

  const GetWatchlistMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class GetWatchlistMovieError extends WatchlistMovieState {
  final String message;

  const GetWatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
