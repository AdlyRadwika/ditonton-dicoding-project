// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveTvWatchlist(mockTvRepository);
  });

  test('should remove watchlist Tv from repository', () async {
    // arrange
    when(mockTvRepository.removeTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeTvWatchlist(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
