import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv_show_season_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_show_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import 'tv_show_season_detail_test.mocks.dart';

@GenerateMocks([TvShowSeasonDetailNotifier])
void main() {
  late MockTvShowSeasonDetailNotifier mockNotifier;
  final seasonArgs = SeasonArgument(1, 1);
  setUp(() {
    mockNotifier = MockTvShowSeasonDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvShowSeasonDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowSeasonState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvShowSeasonDetailPage(
      seasonArgs: seasonArgs,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowSeasonState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowSeason).thenReturn(testTvShowSeasonDetail);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvShowSeasonDetailPage(
      seasonArgs: seasonArgs,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowSeasonState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvShowSeasonDetailPage(
      seasonArgs: seasonArgs,
    )));

    expect(textFinder, findsOneWidget);
  });
}
