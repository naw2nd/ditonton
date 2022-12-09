import 'package:cached_network_image/cached_network_image.dart';
import 'package:tv_shows/presentation/widgets/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';

void main() {
  Widget makeTestableWidget(Widget body) => MaterialApp(
        home: Scaffold(body: body),
      );
  testWidgets('Card should display episode detail when data is loaded',
      (WidgetTester tester) async {
    final finderTitle = find.text('The Heirs of the Dragon');
    final finderOverview = find.text(
      "Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.",
    );
    final finderImage = find.byType(CachedNetworkImage);

    await tester.pumpWidget(
        makeTestableWidget(TvShowEpisodeCard(testTvShowEpisodeList[0])));

    expect(finderTitle, findsOneWidget);
    expect(finderOverview, findsOneWidget);
    expect(finderImage, findsOneWidget);
  });
}
