
import 'package:core/core.dart';
import 'package:core/presentation/pages/entertaiment_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../data/dummy_data/movie_dummy_objects.dart';
import 'entertaiment_movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockMovieNotifier;

  setUp(() {
    mockMovieNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableMovieWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockMovieNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movie).thenReturn(testMovieDetail);
    when(mockMovieNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockMovieNotifier.isAddedToMovieWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableMovieWidget(EntertaimentDetailPage(
      id: 1,
      isTV: false,
    )));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movie).thenReturn(testMovieDetail);
    when(mockMovieNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockMovieNotifier.isAddedToMovieWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableMovieWidget(EntertaimentDetailPage(
      id: 1,
      isTV: false,
    )));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movie).thenReturn(testMovieDetail);
    when(mockMovieNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockMovieNotifier.isAddedToMovieWatchlist).thenReturn(false);
    when(mockMovieNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableMovieWidget(EntertaimentDetailPage(
      id: 1,
      isTV: false,
    )));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockMovieNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movie).thenReturn(testMovieDetail);
    when(mockMovieNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockMovieNotifier.isAddedToMovieWatchlist).thenReturn(false);
    when(mockMovieNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableMovieWidget(EntertaimentDetailPage(
      id: 1,
      isTV: false,
    )));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

}