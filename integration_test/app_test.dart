import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:ditonton/injection.dart' as di;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  group('Home Drawer Test', () {
    testWidgets("Tv Shows Dashboard Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('tv_shows_list_tile_drawer')));
      await tester.pumpAndSettle();

      final firstItem = find.text('Ditonton Tv Shows');
      expect(firstItem, findsOneWidget);

      await di.locator.reset(dispose: true);
    });

    testWidgets("Movies Dashboard Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('tv_shows_list_tile_drawer')));
      await tester.pumpAndSettle();

      final firstItem = find.text('Ditonton Tv Shows');
      expect(firstItem, findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('movies_list_tile_drawer')));
      await tester.pumpAndSettle();

      final seacondItem = find.text('Ditonton Movies');
      expect(seacondItem, findsOneWidget);

      await di.locator.reset(dispose: true);
    });

    testWidgets("Watchlist Page Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('watchlists_list_tile_drawer')));
      await tester.pumpAndSettle();

      final firstItem = find.text('Watchlist Movies');
      expect(firstItem, findsOneWidget);

      await tester.tap(find.byIcon(Icons.tv));
      await tester.pumpAndSettle();

      final secondItem = find.text('Watchlist Tv Shows');
      expect(secondItem, findsOneWidget);

      await di.locator.reset(dispose: true);
    });

    testWidgets("About Page Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('about_list_tile_drawer')));
      await tester.pumpAndSettle();

      final firstItem = find.text(
          'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.');
      expect(firstItem, findsOneWidget);

      await di.locator.reset(dispose: true);
    });
  });

  group('Sacffold Actions Test', () {
    testWidgets("Search Page Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      final firstItem = find.text('Search title');
      expect(firstItem, findsOneWidget);

      await tester.tap(find.byIcon(Icons.tv));
      await tester.pumpAndSettle();

      final secondItem = find.text('Result Tv Shows');
      expect(secondItem, findsOneWidget);

      await tester.tap(find.byIcon(Icons.movie));
      await tester.pumpAndSettle();

      final thirdItem = find.text('Result Movies');
      expect(thirdItem, findsOneWidget);

      await di.locator.reset(dispose: true);
    });

    testWidgets("Crash Dialog Test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.error_outline));
      await tester.pumpAndSettle();

      final firstItem = find.text('Firebase Crashlytics');
      expect(firstItem, findsOneWidget);

      await di.locator.reset(dispose: true);
    });
  });
}
