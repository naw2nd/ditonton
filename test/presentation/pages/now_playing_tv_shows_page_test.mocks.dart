// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/pages/now_playing_tv_shows_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:ditonton/common/state_enum.dart' as _i4;
import 'package:ditonton/domain/entities/tv_show.dart' as _i5;
import 'package:ditonton/domain/usecases/get_now_playing_tv_shows.dart' as _i2;
import 'package:ditonton/presentation/provider/now_playing_tv_shows_notifier.dart'
    as _i3;
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

class _FakeGetNowPlayingTvShows_0 extends _i1.SmartFake
    implements _i2.GetNowPlayingTvShows {
  _FakeGetNowPlayingTvShows_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [NowPlayingTvShowsNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockNowPlayingTvShowsNotifier extends _i1.Mock
    implements _i3.NowPlayingTvShowsNotifier {
  MockNowPlayingTvShowsNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetNowPlayingTvShows get getNowPlayingTvShows =>
      (super.noSuchMethod(Invocation.getter(#getNowPlayingTvShows),
              returnValue: _FakeGetNowPlayingTvShows_0(
                  this, Invocation.getter(#getNowPlayingTvShows)))
          as _i2.GetNowPlayingTvShows);
  @override
  _i4.RequestState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i4.RequestState.Empty) as _i4.RequestState);
  @override
  List<_i5.TvShow> get tvShows =>
      (super.noSuchMethod(Invocation.getter(#tvShows),
          returnValue: <_i5.TvShow>[]) as List<_i5.TvShow>);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchNowPlayingTvShows() => (super.noSuchMethod(
      Invocation.method(#fetchNowPlayingTvShows, []),
      returnValue: _i6.Future<void>.value(),
      returnValueForMissingStub: _i6.Future<void>.value()) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
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