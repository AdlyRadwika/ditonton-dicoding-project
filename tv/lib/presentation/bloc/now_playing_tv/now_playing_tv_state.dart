part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvInitial extends NowPlayingTvState {}

class NowPlayingTvLoading extends NowPlayingTvState {}

class NowPlayingTvEmpty extends NowPlayingTvState {}

class NowPlayingTvHasData extends NowPlayingTvState {
  final List<Tv> nowPlayingTv;

  const NowPlayingTvHasData(this.nowPlayingTv);

  @override
  List<Object> get props => [nowPlayingTv];
}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;

  const NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}
