import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv_shows/tv_shows.dart';
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
