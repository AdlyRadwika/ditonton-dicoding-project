// ignore_for_file: prefer_const_declarations

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockTvDatabaseHelper mockTvDatabaseHelper;

  setUp(() {
    mockTvDatabaseHelper = MockTvDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(tvDatabaseHelper: mockTvDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Tvs', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockTvDatabaseHelper.getWatchlistTvs())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTvs();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
