import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTvs _getNowPlayingTvs;

  NowPlayingTvBloc(this._getNowPlayingTvs) : super(NowPlayingTvInitial()) {
    on<NowPlayingTvEvent>((event, emit) async {
      emit(NowPlayingTvLoading());

      final nowPlayingTvs = await _getNowPlayingTvs.execute();

      nowPlayingTvs.fold(
        (failure) {
          emit(NowPlayingTvError(failure.message));
        },
        (tvsData) {
          if (tvsData.isEmpty) {
            emit(NowPlayingTvEmpty());
          } else {
            emit(NowPlayingTvHasData(tvsData));
          }
        },
      );
    });
  }
}
