import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_show_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowHome extends StatefulWidget {
  @override
  State<TvShowHome> createState() => _TvShowHomeState();
}

class _TvShowHomeState extends State<TvShowHome> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchNowPlayingTvShows()
          ..fetchPopularTvShows()
          ..fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Now Playing',
          style: kHeading6,
        ),
        Consumer<TvShowListNotifier>(builder: (context, data, child) {
          final state = data.nowPlayingState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return TvShowList(data.nowPlayingTvShows);
          } else {
            print(state.toString());
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularTvShowsPage.ROUTE_NAME),
        ),
        Consumer<TvShowListNotifier>(builder: (context, data, child) {
          final state = data.popularTvShowsState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return TvShowList(data.popularTvShows);
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedTvShowsPage.ROUTE_NAME),
        ),

        Consumer<TvShowListNotifier>(builder: (context, data, child) {
          final state = data.topRatedTvShowsState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return TvShowList(data.topRatedTvShows);
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
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
