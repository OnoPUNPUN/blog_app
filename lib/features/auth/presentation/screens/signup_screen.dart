import 'package:blog_app/app/config/routes/app_router.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/screens/login_screen.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name = 'sign-up';

  @override
  State<SignUpScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _nameTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 50, fontWeight: .bold),
              ),
              const SizedBox(height: 30),
              AuthField(hinText: 'Name', controller: _nameTEController),
              const SizedBox(height: 15),
              AuthField(hinText: 'Email', controller: _emailTEController),
              const SizedBox(height: 15),
              AuthField(
                hinText: 'Password',
                controller: _passwordTEController,
                isObscureText: true,
              ),
              const SizedBox(height: 20),
              const AuthGradientButton(buttonText: 'Sign Up'),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Already Have an Account?",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: ' Sign In',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPallete.gradient1,
                        fontWeight: .bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _onTapSignInButton,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    AppRouter.push(context, LogInScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _nameTEController.dispose();
    super.dispose();
  }
}
