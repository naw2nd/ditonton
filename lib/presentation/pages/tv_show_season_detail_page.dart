import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_show_season_detail/tv_show_season_detail_bloc.dart';
import 'package:ditonton/presentation/widgets/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        context.read<TvShowSeasonDetailBloc>().add(OnFetchTvShowSeasonDetail(
              widget.seasonArgs.id,
              widget.seasonArgs.seasonNumber,
            )));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<TvShowSeasonDetailBloc>().add(OnFetchTvShowSeasonDetail(
          widget.seasonArgs.id,
          widget.seasonArgs.seasonNumber,
        ));
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
          child: BlocBuilder<TvShowSeasonDetailBloc, TvShowSeasonDetailState>(
            builder: (context, state) {
              if (state is TvShowSeasonDetailLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvShowSeasonDetailHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final episode = state.result.episodes[index];
                    return TvShowEpisodeCard(episode);
                  },
                  itemCount: state.result.episodes.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text('Failed'),
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
