import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/meal_local_data_source.dart';
import 'data/datasources/meal_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/meal_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/meal_repository.dart';
import 'domain/usecases/auth_usecases.dart';
import 'domain/usecases/get_categories.dart';
import 'domain/usecases/get_meal_details.dart';
import 'domain/usecases/get_meals_by_category.dart';
import 'domain/usecases/manage_favorites.dart';
import 'domain/usecases/search_meals.dart';
import 'presentation/blocs/auth_bloc.dart';
import 'presentation/blocs/category_bloc.dart';
import 'presentation/blocs/favorite_bloc.dart';
import 'presentation/blocs/meal_bloc.dart';
import 'presentation/blocs/meal_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthBloc(
        register: sl(),
        login: sl(),
        logout: sl(),
        getCurrentUser: sl(),
      ));

  sl.registerFactory(() => CategoryBloc(getCategories: sl()));
  sl.registerFactory(() => MealBloc(getMealsByCategory: sl(), searchMeals: sl()));
  sl.registerFactory(() => MealDetailBloc(getMealDetails: sl()));
  sl.registerFactory(() => FavoriteBloc(
        getFavoriteMeals: sl(),
        saveFavoriteMeal: sl(),
        removeFavoriteMeal: sl(),
        checkFavoriteStatus: sl(),
      ));

  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));

  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetMealsByCategory(sl()));
  sl.registerLazySingleton(() => SearchMeals(sl()));
  sl.registerLazySingleton(() => GetMealDetails(sl()));
  sl.registerLazySingleton(() => GetFavoriteMeals(sl()));
  sl.registerLazySingleton(() => SaveFavoriteMeal(sl()));
  sl.registerLazySingleton(() => RemoveFavoriteMeal(sl()));
  sl.registerLazySingleton(() => CheckFavoriteStatus(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        localDataSource: sl(),
      ));

  sl.registerLazySingleton<MealRepository>(() => MealRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));

  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(
        database: sl(),
        sharedPreferences: sl(),
      ));

  sl.registerLazySingleton<MealRemoteDataSource>(
      () => MealRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MealLocalDataSource>(
      () => MealLocalDataSourceImpl(database: sl()));

  sl.registerLazySingleton(() => http.Client());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final database = await openDatabase(
    join(await getDatabasesPath(), 'culinaria_database.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE favorites(idMeal TEXT PRIMARY KEY, strMeal TEXT, strMealThumb TEXT, strCategory TEXT, strArea TEXT, strInstructions TEXT, strYoutube TEXT)',
      );
      await db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT UNIQUE, password TEXT)',
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT UNIQUE, password TEXT)',
        );
      }
    },
    version: 2,
  );
  sl.registerLazySingleton(() => database);
}
