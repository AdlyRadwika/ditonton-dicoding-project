part of 'recommendation_tvs_bloc.dart';

abstract class RecommendationTvsState extends Equatable {
  const RecommendationTvsState();
  
  @override
  List<Object> get props => [];
}

class RecommendationTvsInitial extends RecommendationTvsState {}

class RecommendationTvsLoading extends RecommendationTvsState {}

class RecommendationTvsEmpty extends RecommendationTvsState {}

class RecommendationTvsData extends RecommendationTvsState {
  final List<Tv> recommendationTvs;

  const RecommendationTvsData(this.recommendationTvs);

  @override
  List<Object> get props => [recommendationTvs];
}

class RecommendationTvsError extends RecommendationTvsState {
  final String message;

  const RecommendationTvsError(this.message);

  @override
  List<Object> get props => [message];
}
