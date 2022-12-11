// ignore_for_file: prefer_typing_uninitialized_variables

part of 'recommendation_tvs_bloc.dart';

abstract class RecommendationTvsEvent extends Equatable {
  const RecommendationTvsEvent();

  @override
  List<Object> get props => [];
}

@immutable
class GetRecommendationTvEvent extends RecommendationTvsEvent {
  final idTv;

  const GetRecommendationTvEvent(this.idTv);
}
