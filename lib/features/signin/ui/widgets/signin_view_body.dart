import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprints_shopping_app_with_localization/core/helpers/extensions.dart';
import 'package:sprints_shopping_app_with_localization/core/helpers/spacing.dart';
import 'package:sprints_shopping_app_with_localization/core/routing/routes.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/colors_manager.dart';
import 'package:sprints_shopping_app_with_localization/core/widgets/custom_main_button.dart';
import 'package:sprints_shopping_app_with_localization/features/signin/ui/widgets/do_not_have_an_account_text.dart';
import 'package:sprints_shopping_app_with_localization/features/signin/ui/widgets/login_email_and_password_widget.dart';
import 'package:sprints_shopping_app_with_localization/features/home/widgets/custom_positioned_home_overlay.dart';
import 'package:sprints_shopping_app_with_localization/features/signin/ui/widgets/login_view_welcome_texts.dart';
import 'package:sprints_shopping_app_with_localization/generated/l10n.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Future<void> _signInWithEmailPassword() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidateMode = AutovalidateMode.always);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context);
        context.pushReplacementNamed(Routes.homeView);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      _showErrorDialog(e.message ?? 'Authentication failed');
    } catch (e) {
      Navigator.pop(context);
      _showErrorDialog('An unexpected error occurred');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsManager.primaryColorShade2,
        // title: Text(S.current.error),
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            // child: Text(S.current.ok),
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const CustomPositionedHomeOverlay(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24.h,
                left: 24.w,
                right: 24.w,
                bottom: 24.h,
              ),
              child: Column(
                children: [
                  const LoginViewWelcomeTexts(),
                  verticalSpace(32),
                  Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      children: [
                        LoginEmailAndPasswordWidget(
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        verticalSpace(42),
                        CustomMainButton(
                          onPressed: _signInWithEmailPassword,
                          buttonText: S.of(context).login_button,
                        ),
                        verticalSpace(60),
                        const DontHaveAccountText(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
