import 'package:flutter/material.dart';
import 'package:sprints_shopping_app_with_localization/core/helpers/app_regex.dart';
import 'package:sprints_shopping_app_with_localization/core/helpers/spacing.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/colors_manager.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/font_family_helper.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/styles.dart';
import 'package:sprints_shopping_app_with_localization/core/widgets/custom_main_text_form_field.dart';
import 'package:sprints_shopping_app_with_localization/core/widgets/password_vlaidations.dart';
import 'package:sprints_shopping_app_with_localization/generated/l10n.dart';

class LoginEmailAndPasswordWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginEmailAndPasswordWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginEmailAndPasswordWidget> createState() =>
      _LoginEmailAndPasswordWidgetState();
}

class _LoginEmailAndPasswordWidgetState
    extends State<LoginEmailAndPasswordWidget> {
  bool isObscureText = true;
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    widget.passwordController.addListener(_updatePasswordValidations);
  }

  void _updatePasswordValidations() {
    setState(() {
      hasLowerCase = AppRegex.hasLowerCase(widget.passwordController.text);
      hasUpperCase = AppRegex.hasUpperCase(widget.passwordController.text);
      hasSpecialCharacters =
          AppRegex.hasSpecialCharacter(widget.passwordController.text);
      hasNumber = AppRegex.hasNumber(widget.passwordController.text);
      hasMinLength = AppRegex.hasMinLength(widget.passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMainTextFormFiels(
          fillColor: Colors.transparent,
          labelStyle: Styles.font22AppBar.copyWith(
            fontSize: 13,
            color: ColorsManager.accentColor,
            fontFamily: FontFamilyHelper.suwannaphumBlack,
          ),
          style: Styles.font22AppBar.copyWith(
            fontSize: 13,
            color: Colors.white,
            fontFamily: FontFamilyHelper.suwannaphumBlack,
          ),
          labelText: S.of(context).login_email,
          controller: widget.emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              // return S.current.email_required;
              return "Email is required";
            }
            if (!AppRegex.isEmailValid(value)) {
              // return S.current.invalid_email;
              return "Email is invalid";
            }
            return null;
          },
        ),
        verticalSpace(18),
        CustomMainTextFormFiels(
          fillColor: Colors.transparent,
          labelStyle: Styles.font22AppBar.copyWith(
            fontSize: 13,
            color: ColorsManager.accentColor,
            fontFamily: FontFamilyHelper.suwannaphumBlack,
          ),
          style: Styles.font22AppBar.copyWith(
            fontSize: 13,
            color: Colors.white,
            fontFamily: FontFamilyHelper.suwannaphumBlack,
          ),
          labelText: S.of(context).login_password,
          controller: widget.passwordController,
          isObscureText: isObscureText,
          suffixIcon: IconButton(
            icon: Icon(
              isObscureText ? Icons.visibility_off : Icons.visibility,
              color: ColorsManager.accentColor,
            ),
            onPressed: () => setState(() => isObscureText = !isObscureText),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              // return S.current.password_required;
              return "Password is required";
            }
            if (!AppRegex.isPasswordValid(value)) {
              // return S.current.invalid_password;
              return "Password is invalid";
            }
            return null;
          },
        ),
        verticalSpace(18),
        PasswordValidations(
          hasLowerCase: hasLowerCase,
          hasUpperCase: hasUpperCase,
          hasSpecialCharacters: hasSpecialCharacters,
          hasNumber: hasNumber,
          hasMinLength: hasMinLength,
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.passwordController.removeListener(_updatePasswordValidations);
    super.dispose();
  }
}
