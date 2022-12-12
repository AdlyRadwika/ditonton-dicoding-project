part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvInitial extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvHasData extends TopRatedTvState {
  final List<Tv> topRatedTv;

  const TopRatedTvHasData(this.topRatedTv);

  @override
  List<Object> get props => [topRatedTv];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}
