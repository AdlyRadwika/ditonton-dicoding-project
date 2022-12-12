import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvDetailInitial()) {
    on<GetTvDetailEvent>((event, emit) async {
      emit(TvDetailLoading());

      final detailResult = await _getTvDetail.execute(event.idTv);

      detailResult.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (tv) {
          emit(TvDetailData(tv));
        },
      );
    });
  }
}
