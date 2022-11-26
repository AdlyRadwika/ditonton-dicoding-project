import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  setUp(() {
    di.init();
  });

  Widget _makeTestableWidget(Widget body, [testKey]) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
      ],
      child: MaterialApp(
        key: testKey,
        home: body,
      ),
    );
  }

  testWidgets('should finds a text widget or any other widgets',
      (tester) async {
    final stackWidget = find.byType(Text);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    expect(stackWidget, findsWidgets);
  });
}
