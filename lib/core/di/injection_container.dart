import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hungry_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:hungry_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:hungry_app/features/auth/domain/use_cases/get_current_user_use_case.dart';
import 'package:hungry_app/features/product/data/data_source/product_remote_data_source.dart';
import 'package:hungry_app/features/product/domain/repositories/product_repository.dart';
import 'package:hungry_app/features/product/domain/use_cases/get_side_options_use_case.dart';
import 'package:hungry_app/features/product/domain/use_cases/get_toppings_use_case.dart';
import 'package:hungry_app/features/product/presentation/cubit/product_details_cubit.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login_use_case.dart';
import '../../features/auth/domain/use_cases/logout_use_case.dart';
import '../../features/auth/domain/use_cases/register_use_case.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/home/data/data_source/home_remote_data_source.dart';
import '../../features/home/data/repository/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/use_cases/get_products_use_case.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<FirebaseAuth>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );

  // Cubit
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
    ),
  );

  // Auto Login
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl<AuthRepository>()),
  );

  // Firestore
  sl.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
  );

// Home Data Source
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSource(
      sl<FirebaseFirestore>(),
    ),
  );

// Home Repository
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
      sl<HomeRemoteDataSource>(),
    ),
  );

// Home Use Case
  sl.registerLazySingleton<GetProductsUseCase>(
        () => GetProductsUseCase(
      sl<HomeRepository>(),
    ),
  );

// Home Cubit
  sl.registerFactory<HomeCubit>(
        () => HomeCubit(
      getProductsUseCase: sl<GetProductsUseCase>(),
    ),
  );

  // data source
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSource(sl()),
  );

  // repositiory
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton<GetToppingsUseCase>(
        () => GetToppingsUseCase(sl()),
  );

  sl.registerLazySingleton<GetSideOptionsUseCase>(
        () => GetSideOptionsUseCase(sl()),
  );

  // cubit
  sl.registerFactory<ProductCubit>(
        () => ProductCubit(
      getToppingsUseCase: sl(),
      getSideOptionsUseCase: sl(),
    ),
  );
}
