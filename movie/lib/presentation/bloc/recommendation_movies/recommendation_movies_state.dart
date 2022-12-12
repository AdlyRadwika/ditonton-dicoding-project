part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesState extends Equatable {
  const RecommendationMoviesState();

  @override
  List<Object> get props => [];
}

class RecommendationMoviesInitial extends RecommendationMoviesState {}

class RecommendationMoviesLoading extends RecommendationMoviesState {}

class RecommendationMoviesEmpty extends RecommendationMoviesState {}

class RecommendationMoviesData extends RecommendationMoviesState {
  final List<Movie> recommendationMovies;

  const RecommendationMoviesData(this.recommendationMovies);

  @override
  List<Object> get props => [recommendationMovies];
}

class RecommendationMoviesError extends RecommendationMoviesState {
  final String message;

  const RecommendationMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
