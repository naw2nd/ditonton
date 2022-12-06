import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:movies/movies.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:tv_shows/tv_shows.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedMenu = 'Movies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        key: Key('home_page_drawer'),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              key: Key('tv_shows_list_tile_drawer'),
              leading: Icon(Icons.tv),
              title: Text('Tv Shows'),
              onTap: () {
                setState(() {
                  _selectedMenu = 'Tv Shows';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              key: Key('movies_list_tile_drawer'),
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                setState(() {
                  _selectedMenu = 'Movies';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              key: Key('watchlists_list_tile_drawer'),
              leading: Icon(Icons.save_alt),
              title: Text('Watchlists'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              key: Key('about_list_tile_drawer'),
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton $_selectedMenu'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showCrashDialog();
            },
            icon: Icon(Icons.error_outline),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: _selectedMenu == 'Movies'
                ? MovieDashboardPage()
                : TvShowDashboardPage()),
      ),
    );
  }

  Future<void> _showCrashDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Firebase Crashlytics'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'This is a button to test crash analytics and reported to firebase.'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'If you click the button below, the app will crash immediately',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
            ),
          ],
        );
      },
    );
  }
}
