part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvEvent extends Equatable {
  const NowPlayingTvEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingTvEvent extends NowPlayingTvEvent {}
