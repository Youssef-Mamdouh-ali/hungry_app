import 'package:hungry_app/features/auth/data/data_source/auth_remote_data_source.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw Exception('Failed to create user');
    }

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final credential = await remoteDataSource.login(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw Exception('Failed to login');
    }

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }


  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await remoteDataSource.getCurrentUser();

    if (user == null) {
      return null;
    }

    return UserModel.fromFirebaseUser(user);
  }


}