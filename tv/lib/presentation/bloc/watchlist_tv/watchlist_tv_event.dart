part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class SaveWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const SaveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [TvDetail];
}

class RemoveWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const RemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class GetWatchlistTvStatus extends WatchlistTvEvent {
  final int idTv;

  const GetWatchlistTvStatus(this.idTv);

  @override
  List<Object> get props => [idTv];
}

class GetWatchlistTv extends WatchlistTvEvent {}