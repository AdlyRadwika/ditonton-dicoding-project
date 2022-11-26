// import 'package:ditonton/common/exception.dart';
// import 'package:ditonton/data/datasources/tv/tv_local_data_source.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../../dummy_data/dummy_objects.dart';
// import '../../../helpers/movie/test_helper.mocks.dart';

// void main() {
//   late TvLocalDataSourceImpl dataSource;
//   late MockTvDatabaseHelper mocktvDatabaseHelper;

//   setUp(() {
//     mocktvDatabaseHelper = MockTvDatabaseHelper();
//     dataSource = TvLocalDataSourceImpl(tvDatabaseHelper: mocktvDatabaseHelper);
//   });

//   group('save watchlist', () {
//     test('should return success message when insert to database is success',
//         () async {
//       // arrange
//       when(mocktvDatabaseHelper.inserttvWatchlist(testtvTable))
//           .thenAnswer((_) async => 1);
//       // act
//       final result = await dataSource.insertWatchlist(testtvTable);
//       // assert
//       expect(result, 'Added to Watchlist');
//     });

//     test('should throw DatabaseException when insert to database is failed',
//         () async {
//       // arrange
//       when(mocktvDatabaseHelper.inserttvWatchlist(testtvTable))
//           .thenThrow(Exception());
//       // act
//       final call = dataSource.insertWatchlist(testtvTable);
//       // assert
//       expect(() => call, throwsA(isA<DatabaseException>()));
//     });
//   });

//   group('remove watchlist', () {
//     test('should return success message when remove from database is success',
//         () async {
//       // arrange
//       when(mocktvDatabaseHelper.removetvWatchlist(testtvTable))
//           .thenAnswer((_) async => 1);
//       // act
//       final result = await dataSource.removetvWatchlist(testtvTable);
//       // assert
//       expect(result, 'Removed from Watchlist');
//     });

//     test('should throw DatabaseException when remove from database is failed',
//         () async {
//       // arrange
//       when(mocktvDatabaseHelper.removetvWatchlist(testtvTable))
//           .thenThrow(Exception());
//       // act
//       final call = dataSource.removetvWatchlist(testtvTable);
//       // assert
//       expect(() => call, throwsA(isA<DatabaseException>()));
//     });
//   });

//   group('Get tv Detail By Id', () {
//     final tId = 1;

//     test('should return tv Detail Table when data is found', () async {
//       // arrange
//       when(mocktvDatabaseHelper.gettvById(tId))
//           .thenAnswer((_) async => testtvMap);
//       // act
//       final result = await dataSource.gettvById(tId);
//       // assert
//       expect(result, testtvTable);
//     });

//     test('should return null when data is not found', () async {
//       // arrange
//       when(mocktvDatabaseHelper.gettvById(tId)).thenAnswer((_) async => null);
//       // act
//       final result = await dataSource.gettvById(tId);
//       // assert
//       expect(result, null);
//     });
//   });

//   group('get watchlist tvs', () {
//     test('should return list of tvTable from database', () async {
//       // arrange
//       when(mocktvDatabaseHelper.getWatchlisttvs())
//           .thenAnswer((_) async => [testtvMap]);
//       // act
//       final result = await dataSource.getWatchlisttvs();
//       // assert
//       expect(result, [testtvTable]);
//     });
//   });
// }
