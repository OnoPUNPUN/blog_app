import 'package:blog_app/core/error/expectations.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUpWithEmailPasswrod({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logInWithEmailPasswrod({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSrouceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSrouceImpl(this.supabaseClient);
  @override
  Future<UserModel> logInWithEmailPasswrod({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerExpectation('User is Null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerExpectation(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPasswrod({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw const ServerExpectation('User is Null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerExpectation(e.toString());
    }
  }
}
