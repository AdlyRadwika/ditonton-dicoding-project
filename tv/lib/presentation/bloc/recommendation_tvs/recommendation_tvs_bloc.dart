import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tvs_event.dart';
part 'recommendation_tvs_state.dart';

class RecommendationTvsBloc extends Bloc<RecommendationTvsEvent, RecommendationTvsState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvsBloc(this._getTvRecommendations) : super(RecommendationTvsInitial()) {
    on<GetRecommendationTvEvent>((event, emit) async {
      emit(RecommendationTvsLoading());
      final recommendationResult =
          await _getTvRecommendations.execute(event.idTv);
      recommendationResult.fold(
        (failure) {
          emit(RecommendationTvsError(failure.message));
        },
        (tvs) {
          if (tvs.isEmpty) {
            emit(RecommendationTvsEmpty());
          } else {
            emit(RecommendationTvsData(tvs));
          }
        },
      );
    });
  }
}
