import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_shows/now_playing_tv_shows_bloc.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_shows_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';

class NowPlayingTvShowsEventFake extends Fake
    implements NowPlayingTvShowsEvent {}

class NowPlayingTvShowsStateFake extends Fake
    implements NowPlayingTvShowsState {}

class MockNowPlayingTvShowsBloc
    extends MockBloc<NowPlayingTvShowsEvent, NowPlayingTvShowsState>
    implements NowPlayingTvShowsBloc {}

void main() {
  late MockNowPlayingTvShowsBloc mockNowPlayingTvShowBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayingTvShowsEventFake());
    registerFallbackValue(NowPlayingTvShowsStateFake());
  });

  setUp(() {
    mockNowPlayingTvShowBloc = MockNowPlayingTvShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvShowsBloc>.value(
      value: mockNowPlayingTvShowBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvShowsPage()));
    // await tester.pumpAndSettle();

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowsHasData(testTvShowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvShowBloc.state)
        .thenReturn(NowPlayingTvShowsError('Failed'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
