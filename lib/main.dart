import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:core/presentation/pages/entertaiment_detail_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/now_playing_entertaiments_page.dart';
import 'package:core/presentation/pages/popular_entertaiments_page.dart';
import 'package:core/presentation/pages/search_page.dart';
import 'package:core/presentation/pages/top_rated_entertaiments_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/utils/utils.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case POPULAR_ROUTE:
              final isTV = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => PopularEntertaimentsPage(
                  isTV: isTV,
                ),
                settings: settings,
              );
            case NOW_PLAYING_ROUTE:
              final isTV = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => NowPlayingEntertaimentsPage(
                  isTV: isTV,
                ),
                settings: settings,
              );
            case TOP_RATED_ROUTE:
              final isTV = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => TopRatedEntertaimentsPage(
                  isTV: isTV,
                ),
                settings: settings,
              );
            case DETAIL_ROUTE:
              final args = settings.arguments as EntertaimentDetailArguments;
              return MaterialPageRoute(
                builder: (_) =>
                    EntertaimentDetailPage(id: args.id, isTV: args.isTV),
                settings: settings,
              );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
