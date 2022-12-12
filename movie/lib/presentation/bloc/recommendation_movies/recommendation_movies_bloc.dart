import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_movies_event.dart';
part 'recommendation_movies_state.dart';

class RecommendationMoviesBloc
    extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMoviesBloc(this._getMovieRecommendations)
      : super(RecommendationMoviesInitial()) {
    on<GetRecommendationMovieEvent>((event, emit) async {
      emit(RecommendationMoviesLoading());
      final recommendationResult =
          await _getMovieRecommendations.execute(event.idMovie);
      recommendationResult.fold(
        (failure) {
          emit(RecommendationMoviesError(failure.message));
        },
        (movies) {
          if (movies.isEmpty) {
            emit(RecommendationMoviesEmpty());
          } else {
            emit(RecommendationMoviesData(movies));
          }
        },
      );
    });
  }
}
