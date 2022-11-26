import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/popular_entertaiments_page.dart';
import 'package:ditonton/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv/popular_tvs_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_entertaiments_movie_page_test.mocks.dart';
import 'popular_entertaiments_tv_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier])
void main() {
  late MockPopularMoviesNotifier mockMovieNotifier;
  late MockPopularTvsNotifier mockTvNotifier;

  setUp(() {
    mockMovieNotifier = MockPopularMoviesNotifier();
    mockTvNotifier = MockPopularTvsNotifier();
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

    await tester.pumpWidget(_makeTestableMovieWidget(PopularEntertaimentsPage(isTV: false,)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded for movie',
      (WidgetTester tester) async {
    when(mockMovieNotifier.state).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableMovieWidget(PopularEntertaimentsPage(isTV: false,)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error for movie',
      (WidgetTester tester) async {
    when(mockMovieNotifier.state).thenReturn(RequestState.Error);
    when(mockMovieNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableMovieWidget(PopularEntertaimentsPage(isTV: false,)));

    expect(textFinder, findsOneWidget);
  });

  //TV
  Widget _makeTestableTvWidget(Widget body) {
    return ChangeNotifierProvider<PopularTvsNotifier>.value(
      value: mockTvNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading for Tv',
      (WidgetTester tester) async {
    when(mockTvNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableTvWidget(PopularEntertaimentsPage(isTV: true,)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded for Tv',
      (WidgetTester tester) async {
    when(mockTvNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTvNotifier.tvs).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableTvWidget(PopularEntertaimentsPage(isTV: true,)));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error for Tv',
      (WidgetTester tester) async {
    when(mockTvNotifier.state).thenReturn(RequestState.Error);
    when(mockTvNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableTvWidget(PopularEntertaimentsPage(isTV: true,)));

    expect(textFinder, findsOneWidget);
  });
}
