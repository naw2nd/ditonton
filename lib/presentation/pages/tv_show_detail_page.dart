import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/presentation/bloc/tv_show_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/tv_show_season_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show/detail';

  final int id;
  TvShowDetailPage({required this.id});

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvShowDetailBloc>().add(OnFetchTvShowDetail(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
        builder: (context, state) {
          if (state is TvShowDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvShowDetailHasData) {
            final tvShow = state.result;
            return SafeArea(
              child: DetailContent(tvShow),
            );
          } else {
            return Text('Failed');
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final TvShowDetail tvShow;

  DetailContent(this.tvShow);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<TvShowWatchlistBloc>()
          .add(OnGetTvShowWatchlistStatus(widget.tvShow.id));
      context
          .read<TvShowRecommendationsBloc>()
          .add(OnFetchTvShowRecommendatios(widget.tvShow.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvShow.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<TvShowWatchlistBloc,
                                    TvShowWatchlistState>(
                                listener: (context, state) {
                              if (state is TvShowWatchlistHasData &&
                                  state.message != '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                            }, builder: (context, state) {
                              if (state is TvShowWatchlistHasData) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (state.result == false) {
                                      BlocProvider.of<TvShowWatchlistBloc>(
                                              context)
                                          .add(OnSaveTvShowWatchlist(
                                              widget.tvShow));
                                    } else {
                                      BlocProvider.of<TvShowWatchlistBloc>(
                                              context)
                                          .add(OnRemoveTvShowWatchlist(
                                              widget.tvShow));
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state.result
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvShow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvShow.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvShow.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: widget.tvShow.seasons == null
                                  ? Center(child: Text('No Season Available'))
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final season =
                                            widget.tvShow.seasons![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                TvShowSeasonDetailPage
                                                    .ROUTE_NAME,
                                                arguments: SeasonArgument(
                                                    widget.tvShow.id,
                                                    season.seasonNumber!),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${season.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.tvShow.seasons!.length,
                                    ),
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvShowRecommendationsBloc,
                                TvShowRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvShowRecommendationsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TvShowRecommendationsError) {
                                  return Text(state.message);
                                } else if (state
                                    is TvShowRecommendationsHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvShowDetailPage.ROUTE_NAME,
                                                arguments: tvShow.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
