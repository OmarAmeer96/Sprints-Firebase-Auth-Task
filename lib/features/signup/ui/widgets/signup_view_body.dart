import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sprints_shopping_app_with_localization/core/helpers/extensions.dart';
import 'package:sprints_shopping_app_with_localization/core/helpers/spacing.dart';
import 'package:sprints_shopping_app_with_localization/core/routing/routes.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/colors_manager.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/styles.dart';
import 'package:sprints_shopping_app_with_localization/core/widgets/custom_main_button.dart';
import 'package:sprints_shopping_app_with_localization/features/signup/ui/widgets/already_have_an_account_text.dart';
import 'package:sprints_shopping_app_with_localization/features/signup/ui/widgets/signup_email_and_password_widget.dart';
import 'package:sprints_shopping_app_with_localization/features/home/widgets/custom_positioned_home_overlay.dart';
import 'package:sprints_shopping_app_with_localization/features/signup/ui/widgets/signup_view_welcome_texts.dart';
import 'package:sprints_shopping_app_with_localization/generated/l10n.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Future<void> _signUpWithEmailPassword() async {
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
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      if (mounted) {
        Navigator.pop(context);
        _showSuccessDialog();
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      _showErrorDialog(e.message ?? 'Registration failed');
    } catch (e) {
      Navigator.pop(context);
      _showErrorDialog('An unexpected error occurred');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsManager.primaryColorShade2,
        icon: const Icon(
          Icons.check_circle,
          color: ColorsManager.enabledTextFieldColor,
          size: 32,
        ),
        content: Text(
          'Congratulations, you have signed up successfully!',
          textAlign: TextAlign.center,
          style: Styles.font13GreyBold.copyWith(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pushReplacementNamed(Routes.signinView);
            },
            child: Text(
              'Continue',
              style: Styles.font13GreyBold.copyWith(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsManager.primaryColorShade2,
        icon: const Icon(
          Icons.error,
          color: ColorsManager.enabledTextFieldColor,
          size: 32,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: Styles.font13GreyBold.copyWith(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: Styles.font13GreyBold.copyWith(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
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
                  const SignupViewWelcomeTexts(),
                  verticalSpace(32),
                  Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      children: [
                        SignupEmailAndPasswordWidget(
                          nameController: _nameController,
                          emailController: _emailController,
                          phoneController: _phoneController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                        ),
                        verticalSpace(42),
                        CustomMainButton(
                          onPressed: _signUpWithEmailPassword,
                          buttonText: S.of(context).signup_button,
                        ),
                        verticalSpace(30),
                        const AlreadyHaveAccountText(),
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
