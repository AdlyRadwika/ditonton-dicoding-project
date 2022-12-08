// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/dummy_data/movie_dummy_objects.dart';
import '../../helpers/movie_test_helper.mocks.dart';

void main() {
  late SaveMovieWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveMovieWatchlist(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveMovieWatchlist(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
