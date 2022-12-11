part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendationMovieEvent extends RecommendationMoviesEvent {
  final idMovie;

  GetRecommendationMovieEvent(this.idMovie);
}
