// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/pages/tv_show_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:ditonton/common/state_enum.dart' as _i9;
import 'package:ditonton/domain/entities/tv_show.dart' as _i10;
import 'package:ditonton/domain/entities/tv_show_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart'
    as _i3;
import 'package:ditonton/domain/usecases/get_tv_show_watvhlist_status.dart'
    as _i4;
import 'package:ditonton/domain/usecases/remove_tv_show_watchlist.dart' as _i6;
import 'package:ditonton/domain/usecases/save_tv_show_watchlist.dart' as _i5;
import 'package:ditonton/presentation/provider/tv_show_detail_notifier.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeGetTvShowDetail_0 extends _i1.SmartFake
    implements _i2.GetTvShowDetail {
  _FakeGetTvShowDetail_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetTvShowRecommendations_1 extends _i1.SmartFake
    implements _i3.GetTvShowRecommendations {
  _FakeGetTvShowRecommendations_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetTvShowWatchListStatus_2 extends _i1.SmartFake
    implements _i4.GetTvShowWatchListStatus {
  _FakeGetTvShowWatchListStatus_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSaveTvShowWatchlist_3 extends _i1.SmartFake
    implements _i5.SaveTvShowWatchlist {
  _FakeSaveTvShowWatchlist_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRemoveTvShowWatchlist_4 extends _i1.SmartFake
    implements _i6.RemoveTvShowWatchlist {
  _FakeRemoveTvShowWatchlist_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvShowDetail_5 extends _i1.SmartFake implements _i7.TvShowDetail {
  _FakeTvShowDetail_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvShowDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowDetailNotifier extends _i1.Mock
    implements _i8.TvShowDetailNotifier {
  MockTvShowDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvShowDetail get getTvShowDetail => (super.noSuchMethod(
          Invocation.getter(#getTvShowDetail),
          returnValue:
              _FakeGetTvShowDetail_0(this, Invocation.getter(#getTvShowDetail)))
      as _i2.GetTvShowDetail);
  @override
  _i3.GetTvShowRecommendations get getTvShowRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getTvShowRecommendations),
              returnValue: _FakeGetTvShowRecommendations_1(
                  this, Invocation.getter(#getTvShowRecommendations)))
          as _i3.GetTvShowRecommendations);
  @override
  _i4.GetTvShowWatchListStatus get getTvShowWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getTvShowWatchListStatus),
              returnValue: _FakeGetTvShowWatchListStatus_2(
                  this, Invocation.getter(#getTvShowWatchListStatus)))
          as _i4.GetTvShowWatchListStatus);
  @override
  _i5.SaveTvShowWatchlist get saveTvShowWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveTvShowWatchlist),
              returnValue: _FakeSaveTvShowWatchlist_3(
                  this, Invocation.getter(#saveTvShowWatchlist)))
          as _i5.SaveTvShowWatchlist);
  @override
  _i6.RemoveTvShowWatchlist get removeTvShowWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeTvShowWatchlist),
              returnValue: _FakeRemoveTvShowWatchlist_4(
                  this, Invocation.getter(#removeTvShowWatchlist)))
          as _i6.RemoveTvShowWatchlist);
  @override
  _i7.TvShowDetail get tvShow => (super.noSuchMethod(Invocation.getter(#tvShow),
          returnValue: _FakeTvShowDetail_5(this, Invocation.getter(#tvShow)))
      as _i7.TvShowDetail);
  @override
  _i9.RequestState get tvShowState =>
      (super.noSuchMethod(Invocation.getter(#tvShowState),
          returnValue: _i9.RequestState.Empty) as _i9.RequestState);
  @override
  List<_i10.TvShow> get tvShowRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvShowRecommendations),
          returnValue: <_i10.TvShow>[]) as List<_i10.TvShow>);
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
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlist),
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
  _i11.Future<void> fetchTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchTvShowDetail, [id]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> addWatchlist(_i7.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [tvShow]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromWatchlist(_i7.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [tvShow]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> loadWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
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
