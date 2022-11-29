import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card.dart';
import 'package:ditonton/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  String _selectedWatchlist = 'Movies';
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlistTvShowNotifier>(context, listen: false)
            .fetchWatchlistTvShows());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvShowNotifier>(context, listen: false)
        .fetchWatchlistTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watchlist $_selectedWatchlist',
          style: TextStyle(color: kMikadoYellow),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _selectedWatchlist = 'Movies';
                });
              },
              icon: Icon(
                Icons.movie,
                color: _selectedWatchlist == 'Movies'
                    ? kMikadoYellow
                    : Colors.white,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  _selectedWatchlist = 'Tv Shows';
                });
              },
              icon: Icon(
                Icons.tv,
                color: _selectedWatchlist == 'Tv Shows'
                    ? kMikadoYellow
                    : Colors.white,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _selectedWatchlist == 'Movies'
            ? MovieWatchlist()
            : TvShowWatchlist(),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class MovieWatchlist extends StatelessWidget {
  const MovieWatchlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistMovieNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistState == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.watchlistMovies[index];
              return MovieCard(movie);
            },
            itemCount: data.watchlistMovies.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }
}

class TvShowWatchlist extends StatelessWidget {
  const TvShowWatchlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistTvShowNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistState == RequestState.Loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tvShow = data.watchlistTvShows[index];
              return TvShowCard(tvShow);
            },
            itemCount: data.watchlistTvShows.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }
}
