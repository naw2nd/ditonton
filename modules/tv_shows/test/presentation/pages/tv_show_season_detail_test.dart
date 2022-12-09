import 'package:bloc_test/bloc_test.dart';
import 'package:tv_shows/presentation/bloc/tv_show_season_detail/tv_show_season_detail_bloc.dart';
import 'package:tv_shows/presentation/pages/tv_show_season_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../dummy_data/tv_show_dummy_objects.dart';

class TvShowSeasonDetailEventFake extends Fake
    implements TvShowSeasonDetailEvent {}

class TvShowSeasonDetailStateFake extends Fake
    implements TvShowSeasonDetailState {}

class MockTvShowSeasonDetailBloc
    extends MockBloc<TvShowSeasonDetailEvent, TvShowSeasonDetailState>
    implements TvShowSeasonDetailBloc {}

void main() {
  late MockTvShowSeasonDetailBloc mockBlocTvShowSeasonDetailBloc;
  final seasonArgs = SeasonArgument(1, 1);

  setUpAll(() {
    registerFallbackValue(TvShowSeasonDetailEventFake());
    registerFallbackValue(TvShowSeasonDetailStateFake());
  });

  setUp(() {
    mockBlocTvShowSeasonDetailBloc = MockTvShowSeasonDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvShowSeasonDetailBloc>.value(
      value: mockBlocTvShowSeasonDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBlocTvShowSeasonDetailBloc.state)
        .thenReturn(TvShowSeasonDetailLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TvShowSeasonDetailPage(
      seasonArgs: seasonArgs,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBlocTvShowSeasonDetailBloc.state)
        .thenReturn(TvShowSeasonDetailHasData(testTvShowSeasonDetail));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TvShowSeasonDetailPage(
      seasonArgs: seasonArgs,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBlocTvShowSeasonDetailBloc.state)
        .thenReturn(const TvShowSeasonDetailError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TvShowSeasonDetailPage(
      seasonArgs: seasonArgs,
    )));

    expect(textFinder, findsOneWidget);
  });
}
