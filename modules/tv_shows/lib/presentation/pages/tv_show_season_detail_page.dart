import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:tv_shows/presentation/bloc/tv_show_season_detail/tv_show_season_detail_bloc.dart';
import 'package:tv_shows/presentation/widgets/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowSeasonDetailPage extends StatefulWidget {
  static const routeName = '/tv-show/episodes';
  final SeasonArgument seasonArgs;

  const TvShowSeasonDetailPage({Key? key, required this.seasonArgs})
      : super(key: key);

  @override
  TvShowSeasonDetailPageState createState() => TvShowSeasonDetailPageState();
}

class TvShowSeasonDetailPageState extends State<TvShowSeasonDetailPage>
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

  @override
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
          style: const TextStyle(color: kMikadoYellow),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TvShowSeasonDetailBloc, TvShowSeasonDetailState>(
            builder: (context, state) {
              if (state is TvShowSeasonDetailLoading) {
                return const Center(
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
                return const Center(
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
