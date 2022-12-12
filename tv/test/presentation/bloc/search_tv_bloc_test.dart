// ignore_for_file: unused_local_variable, prefer_const_declarations, prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchTvBloc = SearchTvBloc(mockSearchTvs);
  });

  final tTvModel = Tv(
    genreIds: [18, 10751],
    id: 115646,
    overview: '',
    posterPath: '/w2nOl7KhwcUj11YxEi9Nknj9cqu.jpg',
    name: 'Lisa',
    voteAverage: 6.4,
  );
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'lisa';

  group(
    'Search Tv with bloc',
    () {
      test('initial state should be empty', () {
        expect(searchTvBloc.state, SearchTvEmpty());
      });
      blocTest<SearchTvBloc, SearchTVState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchTvs.execute(tQuery))
              .thenAnswer((_) async => Right(tTvList));
          return searchTvBloc;
        },
        act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          SearchTvLoading(),
          SearchTvHasData(tTvList),
        ],
        verify: (bloc) {
          verify(mockSearchTvs.execute(tQuery));
        },
      );

      blocTest<SearchTvBloc, SearchTVState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSearchTvs.execute(tQuery))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return searchTvBloc;
        },
        act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          SearchTvLoading(),
          SearchTvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSearchTvs.execute(tQuery));
        },
      );
    },
  );
}
