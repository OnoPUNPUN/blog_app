import 'package:blog_app/core/error/expectations.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  const AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, String>> logInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await authRemoteDatasource.signUpWithEmailPasswrod(
        name: name,
        email: email,
        password: password,
      );

      return right(userId);
    } on ServerExpectation catch (e) {
      return left(Failure(e.message));
    }
  }
}
