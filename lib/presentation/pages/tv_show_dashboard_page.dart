import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_shows_bloc.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDashboardPage extends StatefulWidget {
  @override
  State<TvShowDashboardPage> createState() => _TvShowDashboardPageState();
}

class _TvShowDashboardPageState extends State<TvShowDashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvShowsBloc>().add(OnFetchNowPlayingTvShows());
      context.read<PopularTvShowsBloc>().add(OnFetchPopularTvShows());
      context.read<TopRatedTvShowsBloc>().add(OnFetchTopRatedTvShows());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeading(
          title: 'Now Playing',
          onTap: () =>
              Navigator.pushNamed(context, NowPlayingTvShowsPage.ROUTE_NAME),
        ),
        BlocBuilder<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
            builder: (context, state) {
          if (state is NowPlayingTvShowsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingTvShowsHasData) {
            return TvShowList(state.result);
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularTvShowsPage.ROUTE_NAME),
        ),
        BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
            builder: (context, state) {
          if (state is PopularTvShowsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTvShowsHasData) {
            return TvShowList(state.result);
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedTvShowsPage.ROUTE_NAME),
        ),
        BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
            builder: (context, state) {
          if (state is TopRatedTvShowsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTvShowsHasData) {
            return TvShowList(state.result);
          } else {
            return Text('Failed');
          }
        }),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> movies;

  TvShowList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
