import 'package:bloc_test/bloc_test.dart';
import 'package:tv_shows/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_show_recommendations/tv_show_recommendations_bloc.dart';
import 'package:tv_shows/presentation/bloc/tv_show_watchlist/tv_show_watchlist_bloc.dart';
import 'package:tv_shows/presentation/pages/tv_show_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';

class TvShowDetailEventFake extends Fake implements TvShowDetailEvent {}

class TvShowDetailStateFake extends Fake implements TvShowDetailState {}

class MockTvShowDetailBloc extends MockBloc<TvShowDetailEvent, TvShowDetailState>
    implements TvShowDetailBloc {}

class TvShowRecommendationsEventFake extends Fake
    implements TvShowRecommendationsEvent {}

class TvShowRecommendationsStateFake extends Fake
    implements TvShowRecommendationsState {}

class MockTvShowRecommendationsBloc
    extends MockBloc<TvShowRecommendationsEvent, TvShowRecommendationsState>
    implements TvShowRecommendationsBloc {}

class TvShowWatchlistEventFake extends Fake implements TvShowWatchlistEvent {}

class TvShowWatchlistStateFake extends Fake implements TvShowWatchlistState {}

class MockTvShowWatchlistBloc
    extends MockBloc<TvShowWatchlistEvent, TvShowWatchlistState>
    implements TvShowWatchlistBloc {}

void main() {
  late MockTvShowDetailBloc mockTvShowDetailBloc;
  late MockTvShowRecommendationsBloc mockTvShowRecommendationsBloc;
  late MockTvShowWatchlistBloc mockTvShowWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(TvShowDetailEventFake());
    registerFallbackValue(TvShowDetailStateFake());

    registerFallbackValue(TvShowRecommendationsEventFake());
    registerFallbackValue(TvShowRecommendationsStateFake());

    registerFallbackValue(TvShowWatchlistEventFake());
    registerFallbackValue(TvShowWatchlistStateFake());
  });

  setUp(() {
    mockTvShowDetailBloc = MockTvShowDetailBloc();
    mockTvShowRecommendationsBloc = MockTvShowRecommendationsBloc();
    mockTvShowWatchlistBloc = MockTvShowWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvShowDetailBloc>.value(
          value: mockTvShowDetailBloc,
        ),
        BlocProvider<TvShowRecommendationsBloc>.value(
          value: mockTvShowRecommendationsBloc,
        ),
        BlocProvider<TvShowWatchlistBloc>.value(
          value: mockTvShowWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv_show not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => mockTvShowRecommendationsBloc.state)
        .thenReturn(TvShowRecommendationsHasData(testTvShowList));
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(const TvShowWatchlistHasData(false, ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const TvShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv_show is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => mockTvShowRecommendationsBloc.state)
        .thenReturn(TvShowRecommendationsHasData(testTvShowList));
    when(() => mockTvShowWatchlistBloc.state)
        .thenReturn(const TvShowWatchlistHasData(true, ''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const TvShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvShowDetailBloc.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(() => mockTvShowRecommendationsBloc.state)
        .thenReturn(TvShowRecommendationsHasData(testTvShowList));
    whenListen(
        mockTvShowWatchlistBloc,
        Stream.value(
          const TvShowWatchlistHasData(true, 'Added to Watchlist'),
        ),
        initialState: const TvShowWatchlistHasData(false, ''));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const TvShowDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}
