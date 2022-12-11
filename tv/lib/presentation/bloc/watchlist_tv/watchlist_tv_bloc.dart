import 'package:tv/tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final SaveTvWatchlist _saveWatchlist;
  final RemoveTvWatchlist _removeWatchlist;
  final GetTvWatchlistStatus _getWatchListStatus;
  final GetWatchlistTvs _getWatchlistTvs;

  WatchlistTvBloc(this._saveWatchlist, this._removeWatchlist, this._getWatchListStatus, this._getWatchlistTvs) : super(WatchlistTvInitial()) {
    on<SaveWatchlistTv>((event, emit) async {
      emit(SaveWatchlistTvLoading());
      final result = await _saveWatchlist.execute(event.tvDetail);

      result.fold(
        (failure) {
          emit(SaveWatchlistTvError(failure.message));
        },
        (tvData) {
          emit(SaveWatchlistTvSuccess(tvData));
          emit(const GetWatchlistTvStatusData(true));
        },
      );
    });

    on<RemoveWatchlistTv>((event, emit) async {
        emit(RemoveWatchlistTvLoading());
        final result = await _removeWatchlist.execute(event.tvDetail);

        result.fold(
          (failure) {
            emit(RemoveWatchlistTvError(failure.message));
          },
          (tvData) {
            emit(RemoveWatchlistTvSuccess(tvData));
            emit(const GetWatchlistTvStatusData(false));
          },
        );
      });
    
    on<GetWatchlistTvStatus>((event, emit) async {
      emit(GetWatchlistTvStatusLoading());

      final result = await _getWatchListStatus.execute(event.idTv);

      emit(GetWatchlistTvStatusData(result));
    });

    on<GetWatchlistTv>((event, emit) async {
      emit(GetWatchlistTvLoading());

      final watchlistTv = await _getWatchlistTvs.execute();

      watchlistTv.fold(
        (failure) {
          emit(GetWatchlistTvError(failure.message));
        },
        (tvsData) {
          if (tvsData.isEmpty) {
            emit(GetWatchlistTvEmpty());
          } else {
            emit(GetWatchlistTvHasData(tvsData));
          }
        },
      );
    });
  }
}