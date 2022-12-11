import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvs _getPopularTvs;

  PopularTvBloc(this._getPopularTvs) : super(PopularTvInitial()) {
    on<PopularTvEvent>((event, emit) async {
      emit(PopularTvLoading());

      final popularTvs = await _getPopularTvs.execute();

      popularTvs.fold(
        (failure) {
          emit(PopularTvError(failure.message));
        },
        (tvsData) {
          if (tvsData.isEmpty) {
            emit(PopularTvEmpty());
          } else {
            emit(PopularTvHasData(tvsData));
          }
        },
      );
    });
  }
}
