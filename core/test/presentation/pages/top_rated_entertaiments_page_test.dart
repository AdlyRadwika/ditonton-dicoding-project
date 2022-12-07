// ignore_for_file: avoid_relative_lib_imports, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/presentation/pages/top_rated_entertaiments_page.dart';
import 'package:core/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/tv/top_rated_tvs_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_entertaiments_movie_page_test.mocks.dart';
import 'top_rated_entertaiments_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesNotifier])
void main() {
  late MockTopRatedMoviesNotifier mockMovieNotifier;
  late MockTopRatedTvsNotifier mockTvNotifier;

  setUp(() {
    mockMovieNotifier = MockTopRatedMoviesNotifier();
    mockTvNotifier = MockTopRatedTvsNotifier();
  });

  Widget _makeTestableMovieWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
      value: mockMovieNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading for movie',
      (WidgetTester tester) async {
    when(mockMovieNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableMovieWidget(TopRatedEntertaimentsPage(
      isTV: false,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded for movie',
      (WidgetTester tester) async {
    when(mockMovieNotifier.state).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableMovieWidget(TopRatedEntertaimentsPage(
      isTV: false,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error for movie',
      (WidgetTester tester) async {
    when(mockMovieNotifier.state).thenReturn(RequestState.Error);
    when(mockMovieNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableMovieWidget(TopRatedEntertaimentsPage(
      isTV: false,
    )));

    expect(textFinder, findsOneWidget);
  });

  //TV
  Widget _makeTestableTvWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvsNotifier>.value(
      value: mockTvNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading for Tv',
      (WidgetTester tester) async {
    when(mockTvNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableTvWidget(TopRatedEntertaimentsPage(
      isTV: true,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded for Tv',
      (WidgetTester tester) async {
    when(mockTvNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTvNotifier.tvs).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableTvWidget(TopRatedEntertaimentsPage(
      isTV: true,
    )));

    expect(listViewFinder, findsOneWidget);
  });
}
