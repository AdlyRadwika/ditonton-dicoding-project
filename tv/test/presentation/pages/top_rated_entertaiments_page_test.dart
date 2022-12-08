// ignore_for_file: prefer_const_constructors

import 'package:tv/tv.dart';
import 'package:core/presentation/pages/top_rated_entertaiments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_entertaiments_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedTvsNotifier])
void main() {
  late MockTopRatedTvsNotifier mockTvNotifier;

  setUp(() {
    mockTvNotifier = MockTopRatedTvsNotifier();
  });

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
