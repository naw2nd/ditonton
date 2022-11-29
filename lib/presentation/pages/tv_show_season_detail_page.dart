import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/tv_show_season_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show/episodes';
  final SeasonArgument seasonArgs;

  const TvShowSeasonDetailPage({Key? key, required this.seasonArgs})
      : super(key: key);

  @override
  _TvShowSeasonDetailPageState createState() => _TvShowSeasonDetailPageState();
}

class _TvShowSeasonDetailPageState extends State<TvShowSeasonDetailPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowSeasonDetailNotifier>(context, listen: false)
            .fetchTvShowSeasonDetail(
                widget.seasonArgs.id, widget.seasonArgs.seasonNumber));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<TvShowSeasonDetailNotifier>(context, listen: false)
        .fetchTvShowSeasonDetail(
            widget.seasonArgs.id, widget.seasonArgs.seasonNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Season ${widget.seasonArgs.seasonNumber}',
          style: TextStyle(color: kMikadoYellow),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TvShowSeasonDetailNotifier>(
            builder: (context, data, child) {
              if (data.tvShowSeasonState == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.tvShowSeasonState == RequestState.Loaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final episode = data.tvShowSeason.episodes[index];
                    return TvShowEpisodeCard(episode);
                  },
                  itemCount: data.tvShowSeason.episodes.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
                );
              }
            },
          )),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class SeasonArgument {
  final int id;
  final int seasonNumber;

  SeasonArgument(this.id, this.seasonNumber);
}
