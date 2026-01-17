import 'package:blog_app/core/error/expectations.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  const AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDatasource.signUpWithEmailPasswrod(
        name: name,
        email: email,
        password: password,
      );

      return right(user);
    } on ServerExpectation catch (e) {
      return left(Failure(e.message));
    }
  }
}
