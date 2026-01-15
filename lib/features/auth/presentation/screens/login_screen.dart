import 'package:blog_app/app/config/routes/app_router.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/auth_routes.dart';
import 'package:blog_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});
  static const String name = 'sign-in';

  @override
  State<LogInScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 50, fontWeight: .bold),
              ),
              const SizedBox(height: 30),

              AuthField(hinText: 'Email', controller: _emailTEController),
              const SizedBox(height: 15),
              AuthField(
                hinText: 'Password',
                controller: _passwordTEController,
                isObscureText: true,
              ),
              const SizedBox(height: 20),
              const AuthGradientButton(buttonText: 'Sign In'),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Don't Have an Account?",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: ' Sign Up',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppPallete.gradient1,
                        fontWeight: .bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _onTapSignUpButton,
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

  void _onTapSignUpButton() {
    AppRouter.push(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
