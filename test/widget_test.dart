import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // this package only done integration_test, unit test and widget test only done in movies and tv shows package
  testWidgets('Aboout Page Test', (WidgetTester tester) async {
    final aboutText = find.text(
      'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
    );

    await tester.pumpWidget(MaterialApp(
      home: AboutPage(),
    ));

    expect(aboutText, findsOneWidget);
  });
}
