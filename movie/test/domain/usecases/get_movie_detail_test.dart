// ignore_for_file: prefer_const_declarations

import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/dummy_data/movie_dummy_objects.dart';
import '../../helpers/movie_test_helper.mocks.dart';

void main() {
  late GetMovieDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetail(mockMovieRepository);
  });

  final tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testMovieDetail));
  });
}
