import 'package:ditonton/common/http_ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_show_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_shows.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/remove_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_shows_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_season_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_shows_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsBloc(
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      getMovieWatchlistStatus: locator(),
      removeMovieWatchlist: locator(),
      saveMovieWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMoviesBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailBloc(
      getTvShowDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowRecommendationsBloc(
      getTvShowRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowWatchlistBloc(
      getTvShowWatchlistStatus: locator(),
      removeTvShowWatchlist: locator(),
      saveTvShowWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvShowsBloc(
      searchTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowsBloc(
      getPopularTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvShowsBloc(
      getNowPlayingTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvShowsBloc(
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvShowsBloc(
      getWatchlistTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowSeasonDetailBloc(
      getTvShowSeasonDetail: locator(),
    ),
  );
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveTvShowWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvShowWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowSeasonDetail(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
