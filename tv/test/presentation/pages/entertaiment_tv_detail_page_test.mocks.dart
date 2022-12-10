// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/pages/entertaiment_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes, avoid_relative_lib_imports

import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:core/utils/state_enum.dart' as _i9;
import 'package:tv/domain/entities/tv.dart' as _i10;
import 'package:tv/domain/entities/tv_detail.dart' as _i7;
import 'package:tv/domain/usecases/get_tv_detail.dart' as _i2;
import 'package:tv/domain/usecases/get_tv_recommendations.dart' as _i3;
import 'package:tv/domain/usecases/get_watchlist_status.dart' as _i4;
import 'package:tv/domain/usecases/remove_watchlist.dart' as _i6;
import 'package:tv/domain/usecases/save_watchlist.dart' as _i5;
import 'package:tv/presentation/provider/tv_detail_notifier.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGetTvDetail extends _i1.Fake implements _i2.GetTvDetail {}

class _FakeGetTvRecommendations extends _i1.Fake
    implements _i3.GetTvRecommendations {}

class _FakeGetTvWatchlistStatus extends _i1.Fake
    implements _i4.GetTvWatchlistStatus {}

class _FakeSaveTvWatchlist extends _i1.Fake implements _i5.SaveTvWatchlist {}

class _FakeRemoveTvWatchlist extends _i1.Fake implements _i6.RemoveTvWatchlist {
}

class _FakeTvDetail extends _i1.Fake implements _i7.TvDetail {}

/// A class which mocks [TvDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailNotifier extends _i1.Mock implements _i8.TvDetailNotifier {
  MockTvDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail =>
      (super.noSuchMethod(Invocation.getter(#getTvDetail),
          returnValue: _FakeGetTvDetail()) as _i2.GetTvDetail);
  @override
  _i3.GetTvRecommendations get getTvRecommendations => (super.noSuchMethod(
      Invocation.getter(#getTvRecommendations),
      returnValue: _FakeGetTvRecommendations()) as _i3.GetTvRecommendations);
  _i4.GetTvWatchlistStatus get getTvWatchlistStatus => (super.noSuchMethod(
      Invocation.getter(#GetTvWatchlistStatus),
      returnValue: _FakeGetTvWatchlistStatus()) as _i4.GetTvWatchlistStatus);
  @override
  _i5.SaveTvWatchlist get saveTvWatchlist =>
      (super.noSuchMethod(Invocation.getter(#SaveTvWatchlist),
          returnValue: _FakeSaveTvWatchlist()) as _i5.SaveTvWatchlist);
  @override
  _i6.RemoveTvWatchlist get removeTvWatchlist =>
      (super.noSuchMethod(Invocation.getter(#RemoveTvWatchlist),
          returnValue: _FakeRemoveTvWatchlist()) as _i6.RemoveTvWatchlist);
  @override
  _i7.TvDetail get tv =>
      (super.noSuchMethod(Invocation.getter(#Tv), returnValue: _FakeTvDetail())
          as _i7.TvDetail);
  @override
  _i9.RequestState get tvState =>
      (super.noSuchMethod(Invocation.getter(#TvState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  List<_i10.Tv> get tvRecommendations =>
      (super.noSuchMethod(Invocation.getter(#TvRecommendations),
          returnValue: <_i10.Tv>[]) as List<_i10.Tv>);
  @override
  _i9.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToTvWatchlist),
          returnValue: false) as bool);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i11.Future<void> fetchTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchTvDetail, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> addTvWatchlist(_i7.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#addTvWatchlist, [tv]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromTvWatchlist(_i7.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeFromTvWatchlist, [tv]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> loadTvWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadTvWatchlistStatus, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}