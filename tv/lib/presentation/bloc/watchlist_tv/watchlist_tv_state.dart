part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

class SaveWatchlistTvLoading extends WatchlistTvState {}

class SaveWatchlistTvSuccess extends WatchlistTvState {
  final String tvData;

  const SaveWatchlistTvSuccess(this.tvData);

  @override
  List<Object> get props => [tvData];
}

class SaveWatchlistTvError extends WatchlistTvState {
  final String message;

  const SaveWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveWatchlistTvLoading extends WatchlistTvState {}

class RemoveWatchlistTvSuccess extends WatchlistTvState {
  final String tvData;

  const RemoveWatchlistTvSuccess(this.tvData);

  @override
  List<Object> get props => [tvData];
}

class RemoveWatchlistTvError extends WatchlistTvState {
  final String message;

  const RemoveWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

abstract class GetWatchlistTvStatusState extends Equatable {
  const GetWatchlistTvStatusState();

  @override
  List<Object> get props => [];
}

class GetWatchlistTvStatusInitial extends WatchlistTvState {}

class GetWatchlistTvStatusLoading extends WatchlistTvState {}

class GetWatchlistTvStatusData extends WatchlistTvState {
  final bool isAddedWatchlist;

  const GetWatchlistTvStatusData(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}

class GetWatchlistTvStatusError extends WatchlistTvState {
  final String message;

  const GetWatchlistTvStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class GetWatchlistTvLoading extends WatchlistTvState {}

class GetWatchlistTvEmpty extends WatchlistTvState {}

class GetWatchlistTvHasData extends WatchlistTvState {
  final List<Tv> tvs;

  const GetWatchlistTvHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class GetWatchlistTvError extends WatchlistTvState {
  final String message;

  const GetWatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}
