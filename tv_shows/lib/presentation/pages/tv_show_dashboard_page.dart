import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/presentation/bloc/now_playing_tv_shows/now_playing_tv_shows_bloc.dart';
import 'package:tv_shows/presentation/bloc/popular_tv_shows/popular_tv_shows_bloc.dart';
import 'package:tv_shows/presentation/bloc/top_rated_tv_shows/top_rated_tv_shows_bloc.dart';
import 'package:tv_shows/presentation/pages/now_playing_tv_shows_page.dart';
import 'package:tv_shows/presentation/pages/popular_tv_shows_page.dart';
import 'package:tv_shows/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv_shows/presentation/pages/tv_show_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDashboardPage extends StatefulWidget {
  const TvShowDashboardPage({super.key});

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
              Navigator.pushNamed(context, NowPlayingTvShowsPage.routeName),
        ),
        BlocBuilder<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
            builder: (context, state) {
          if (state is NowPlayingTvShowsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingTvShowsHasData) {
            return TvShowList(state.result);
          } else {
            return const Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularTvShowsPage.routeName),
        ),
        BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
            builder: (context, state) {
          if (state is PopularTvShowsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTvShowsHasData) {
            return TvShowList(state.result);
          } else {
            return const Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedTvShowsPage.routeName),
        ),
        BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
            builder: (context, state) {
          if (state is TopRatedTvShowsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTvShowsHasData) {
            return TvShowList(state.result);
          } else {
            return const Text('Failed');
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
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> movies;

  const TvShowList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  TvShowDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
