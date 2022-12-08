// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
  );

  final ttv = Tv(
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
  );

  test('should be a subclass of tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, ttv);
  });
}
