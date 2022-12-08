// ignore_for_file: avoid_relative_lib_imports, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:core/presentation/pages/popular_entertaiments_page.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_entertaiments_tv_page_test.mocks.dart';

@GenerateMocks([PopularTvsNotifier])
void main() {
  late MockPopularTvsNotifier mockTvNotifier;

  setUp(() {
    mockTvNotifier = MockPopularTvsNotifier();
  });

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

    await tester.pumpWidget(_makeTestableTvWidget(PopularEntertaimentsPage(
      isTV: true,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded for Tv',
      (WidgetTester tester) async {
    when(mockTvNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTvNotifier.tvs).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableTvWidget(PopularEntertaimentsPage(
      isTV: true,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error for Tv',
      (WidgetTester tester) async {
    when(mockTvNotifier.state).thenReturn(RequestState.Error);
    when(mockTvNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableTvWidget(PopularEntertaimentsPage(
      isTV: true,
    )));

    expect(textFinder, findsOneWidget);
  });
}
