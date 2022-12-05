import 'package:ditonton/presentation/bloc/popular_tv_shows_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvShow';

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvShowsBloc>().add(OnFetchPopularTvShows()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TvShows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
          builder: (context, state) {
            if (state is PopularTvShowsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvShowsHasData) {
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
