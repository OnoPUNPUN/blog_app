import 'package:blog_app/core/error/expectations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUpWithEmailPasswrod({
    required String name,
    required String email,
    required String password,
  });

  Future<String> logInWithEmailPasswrod({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSrouceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSrouceImpl(this.supabaseClient);
  @override
  Future<String> logInWithEmailPasswrod({
    required String email,
    required String password,
  }) {
    //TODO: Implment This
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPasswrod({
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
      return response.user!.id;
    } catch (e) {
      throw ServerExpectation(e.toString());
    }
  }
}
