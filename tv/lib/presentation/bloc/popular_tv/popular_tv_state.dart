part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvInitial extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvEmpty extends PopularTvState {}

class PopularTvHasData extends PopularTvState {
  final List<Tv> popularTv;

  const PopularTvHasData(this.popularTv);

  @override
  List<Object> get props => [popularTv];
}

class PopularTvError extends PopularTvState {
  final String message;

  const PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}
