import 'package:tv_shows/presentation/bloc/now_playing_tv_shows/now_playing_tv_shows_bloc.dart';
import 'package:tv_shows/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvShowsPage extends StatefulWidget {
  static const routeName = '/now-playing-tvShow';

  const NowPlayingTvShowsPage({super.key});

  @override
  NowPlayingTvShowsPageState createState() => NowPlayingTvShowsPageState();
}

class NowPlayingTvShowsPageState extends State<NowPlayingTvShowsPage> {
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
        title: const Text('NowPlaying TvShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
          builder: (context, state) {
            if (state is NowPlayingTvShowsLoading) {
              return const Center(
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
              return const Center(
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
