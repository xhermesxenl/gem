import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/items/data/datasources/item_remote_data_source.dart';
import '../../features/items/data/repositories/item_repository_impl.dart';
import '../../features/items/domain/repositories/item_repository.dart';
import '../../features/items/domain/usecases/get_items.dart';
import '../../features/items/domain/usecases/add_item.dart';
import '../../features/items/domain/usecases/update_item.dart';
import '../../features/items/domain/usecases/delete_item.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Supabase client
  sl.registerLazySingleton(() => Supabase.instance.client);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton(() => Login(sl()));


  // Items
  sl.registerLazySingleton<ItemRemoteDataSource>(
      () => ItemRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ItemRepository>(
      () => ItemRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetItems(sl()));
  sl.registerLazySingleton(() => AddItem(sl()));
  sl.registerLazySingleton(() => UpdateItem(sl()));
  sl.registerLazySingleton(() => DeleteItem(sl()));



}
