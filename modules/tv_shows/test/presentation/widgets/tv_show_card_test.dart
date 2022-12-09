import 'package:cached_network_image/cached_network_image.dart';
import 'package:tv_shows/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';

void main() {
  Widget makeTestableWidget(Widget body) => MaterialApp(
        home: Scaffold(body: body),
      );
  testWidgets('Card should display movie datail when data is loaded',
      (WidgetTester tester) async {
    final finderTitle = find.text('name');
    final finderOverview = find.text('overview');
    final finderImage = find.byType(CachedNetworkImage);

    await tester.pumpWidget(makeTestableWidget(TvShowCard(testTvShow)));

    expect(finderTitle, findsOneWidget);
    expect(finderOverview, findsOneWidget);
    expect(finderImage, findsOneWidget);
  });
}
