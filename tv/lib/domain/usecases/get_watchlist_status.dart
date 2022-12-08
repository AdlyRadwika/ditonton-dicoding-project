import 'package:tv/tv.dart';

class GetTvWatchlistStatus {
  final TvRepository repository;

  GetTvWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToTvWatchlist(id);
  }
}
