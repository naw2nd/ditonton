import 'package:tv_shows/presentation/bloc/popular_tv_shows/popular_tv_shows_bloc.dart';
import 'package:tv_shows/presentation/pages/popular_tv_shows_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';

class PopularTvShowsEventFake extends Fake implements PopularTvShowsEvent {}

class PopularTvShowsStateFake extends Fake implements PopularTvShowsState {}

class MockPopularTvShowsBloc
    extends MockBloc<PopularTvShowsEvent, PopularTvShowsState>
    implements PopularTvShowsBloc {}

void main() {
  late MockPopularTvShowsBloc mockPopularTvShowsBloc;

  setUpAll(() {
    registerFallbackValue(PopularTvShowsEventFake());
    registerFallbackValue(PopularTvShowsStateFake());
  });

  setUp(() {
    mockPopularTvShowsBloc = MockPopularTvShowsBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvShowsBloc>.value(
      value: mockPopularTvShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state)
        .thenReturn(PopularTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state)
        .thenReturn(PopularTvShowsHasData(testTvShowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvShowsBloc.state)
        .thenReturn(const PopularTvShowsError('Failed'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
