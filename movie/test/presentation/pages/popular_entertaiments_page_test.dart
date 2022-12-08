// ignore_for_file: avoid_relative_lib_imports, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:core/utils/state_enum.dart';
import 'package:core/presentation/pages/popular_entertaiments_page.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_entertaiments_movie_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier])
void main() {
  late MockPopularMoviesNotifier mockMovieNotifier;

  setUp(() {
    mockMovieNotifier = MockPopularMoviesNotifier();
  });

  Widget _makeTestableMovieWidget(Widget body) {
    return ChangeNotifierProvider<PopularMoviesNotifier>.value(
      value: mockMovieNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading for movie',
      (WidgetTester tester) async {
    when(mockMovieNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableMovieWidget(PopularEntertaimentsPage(
      isTV: false,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded for movie',
      (WidgetTester tester) async {
    when(mockMovieNotifier.state).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableMovieWidget(PopularEntertaimentsPage(
      isTV: false,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error for movie',
      (WidgetTester tester) async {
    when(mockMovieNotifier.state).thenReturn(RequestState.Error);
    when(mockMovieNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableMovieWidget(PopularEntertaimentsPage(
      isTV: false,
    )));

    expect(textFinder, findsOneWidget);
  });
}
