import 'package:ditonton/presentation/bloc/now_playing_tv_shows_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tvShow';

  @override
  _NowPlayingTvShowsPageState createState() => _NowPlayingTvShowsPageState();
}

class _NowPlayingTvShowsPageState extends State<NowPlayingTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NowPlayingTvShowsBloc>().add(OnFetchNowPlayingTvShows()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NowPlaying TvShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
          builder: (context, state) {
            if (state is NowPlayingTvShowsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvShowsHasData) {
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
        ),
      ),
    );
  }
}
