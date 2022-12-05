import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_shows/watchlist_tv_shows_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card.dart';
import 'package:ditonton/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(OnFetchWatchlistMovies());
      context.read<WatchlistTvShowsBloc>().add(OnFetchWatchlistTvShows());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(OnFetchWatchlistMovies());
    context.read<WatchlistTvShowsBloc>().add(OnFetchWatchlistTvShows());
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
    return BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
      builder: (context, state) {
        if (state is WatchlistMoviesLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistMoviesHasData) {
          if (state.result.isEmpty) {
            return Center(
              child: Text('Movies Watchlist is Empty'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.result[index];
              return MovieCard(movie);
            },
            itemCount: state.result.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text('Failed'),
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
    return BlocBuilder<WatchlistTvShowsBloc, WatchlistTvShowsState>(
      builder: (context, state) {
        if (state is WatchlistTvShowsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistTvShowsHasData) {
          if (state.result.isEmpty) {
            return Center(
              child: Text('Tv Shows Watchlist is Empty'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final tvShow = state.result[index];
              return TvShowCard(tvShow);
            },
            itemCount: state.result.length,
          );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text('Failed'),
          );
        }
      },
    );
  }
}
