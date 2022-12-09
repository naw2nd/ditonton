import 'package:tv_shows/presentation/bloc/top_rated_tv_shows/top_rated_tv_shows_bloc.dart';
import 'package:tv_shows/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  static const routeName = '/top-rated-tv-show';

  const TopRatedTvShowsPage({super.key});

  @override
  TopRatedTvShowsPageState createState() => TopRatedTvShowsPageState();
}

class TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvShowsBloc>().add(OnFetchTopRatedTvShows()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TvShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
          builder: (context, state) {
            if (state is TopRatedTvShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvShowsHasData) {
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
