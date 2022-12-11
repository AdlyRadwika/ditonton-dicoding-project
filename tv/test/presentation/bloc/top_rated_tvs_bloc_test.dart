// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTvs);
  });

  group('Top rated Tvs', () {
      blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, HasData] when top rated Tv data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvEvent()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Empty] when top rated Tv data is empty',
    build: () {
      when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Right([]));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvEvent()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when get top rated Tvs is unsuccessful',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvEvent()),
    expect: () => [
      TopRatedTvLoading(),
      const TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );
  },);
}