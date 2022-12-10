// Mocks generated by Mockito 5.3.2 from annotations
// in movie/test/helpers/movie_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:convert' as _i7;
import 'dart:typed_data' as _i8;

import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/movie.dart' as _i3;
import 'package:sqflite/sqflite.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i3.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
            _FakeEither_0<_i3.Failure, List<_i3.Movie>>(
          this,
          Invocation.method(
            #getNowPlayingMovies,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
            _FakeEither_0<_i3.Failure, List<_i3.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
            _FakeEither_0<_i3.Failure, List<_i3.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, _i3.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, _i3.MovieDetail>>.value(
            _FakeEither_0<_i3.Failure, _i3.MovieDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, _i3.MovieDetail>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
            _FakeEither_0<_i3.Failure, List<_i3.Movie>>(
          this,
          Invocation.method(
            #getMovieRecommendations,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
            _FakeEither_0<_i3.Failure, List<_i3.Movie>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, String>> saveMovieWatchlist(
          _i3.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveMovieWatchlist,
          [movie],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, String>>.value(
            _FakeEither_0<_i3.Failure, String>(
          this,
          Invocation.method(
            #saveMovieWatchlist,
            [movie],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, String>> removeMovieWatchlist(
          _i3.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeMovieWatchlist,
          [movie],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, String>>.value(
            _FakeEither_0<_i3.Failure, String>(
          this,
          Invocation.method(
            #removeMovieWatchlist,
            [movie],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i5.Future<bool> isAddedToMovieWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToMovieWatchlist,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
            _FakeEither_0<_i3.Failure, List<_i3.Movie>>(
          this,
          Invocation.method(
            #getWatchlistMovies,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i3.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i3.MovieModel>> getNowPlayingMovies() => (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);
  @override
  _i5.Future<List<_i3.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);
  @override
  _i5.Future<List<_i3.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);
  @override
  _i5.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i5.Future<_i3.MovieDetailResponse>.value(
            _FakeMovieDetailResponse_1(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.MovieDetailResponse>);
  @override
  _i5.Future<List<_i3.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);
  @override
  _i5.Future<List<_i3.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i3.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String> insertWatchlist(_i3.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [movie],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<String> removeMovieWatchlist(_i3.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeMovieWatchlist,
          [movie],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<_i3.MovieTable?> getMovieById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i5.Future<_i3.MovieTable?>.value(),
      ) as _i5.Future<_i3.MovieTable?>);
  @override
  _i5.Future<List<_i3.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i5.Future<List<_i3.MovieTable>>.value(<_i3.MovieTable>[]),
      ) as _i5.Future<List<_i3.MovieTable>>);
}

/// A class which mocks [MovieDatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDatabaseHelper extends _i1.Mock
    implements _i3.MovieDatabaseHelper {
  MockMovieDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i6.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i5.Future<_i6.Database?>.value(),
      ) as _i5.Future<_i6.Database?>);
  @override
  _i5.Future<int> insertMovieWatchlist(_i3.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertMovieWatchlist,
          [movie],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<int> removeMovieWatchlist(_i3.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeMovieWatchlist,
          [movie],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i5.Future<Map<String, dynamic>?>.value(),
      ) as _i5.Future<Map<String, dynamic>?>);
  @override
  _i5.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i5.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i5.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i5.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i5.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i5.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i5.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i5.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i5.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i5.Future<_i4.Response>);
  @override
  _i5.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<_i8.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i5.Future<_i8.Uint8List>.value(_i8.Uint8List(0)),
      ) as _i5.Future<_i8.Uint8List>);
  @override
  _i5.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i5.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i5.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
