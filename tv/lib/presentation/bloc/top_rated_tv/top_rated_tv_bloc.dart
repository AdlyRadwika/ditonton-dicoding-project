import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvs _getTopRatedTvs;

  TopRatedTvBloc(this._getTopRatedTvs) : super(TopRatedTvInitial()) {
    on<TopRatedTvEvent>((event, emit) async {
      emit(TopRatedTvLoading());

      final popularTvs = await _getTopRatedTvs.execute();

      popularTvs.fold(
        (failure) {
          emit(TopRatedTvError(failure.message));
        },
        (tvsData) {
          if (tvsData.isEmpty) {
            emit(TopRatedTvEmpty());
          } else {
            emit(TopRatedTvHasData(tvsData));
          }
        },
      );
    });
  }
}
