import 'package:sprints_shopping_app_with_localization/core/helpers/app_regex.dart';
import 'package:sprints_shopping_app_with_localization/core/helpers/spacing.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/colors_manager.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/font_family_helper.dart';
import 'package:sprints_shopping_app_with_localization/core/theming/styles.dart';
import 'package:sprints_shopping_app_with_localization/core/widgets/custom_main_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:sprints_shopping_app_with_localization/generated/l10n.dart';

class SignupEmailAndPasswordWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignupEmailAndPasswordWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<SignupEmailAndPasswordWidget> createState() =>
      _SignupEmailAndPasswordWidgetState();
}

class _SignupEmailAndPasswordWidgetState
    extends State<SignupEmailAndPasswordWidget> {
  bool isPassObscure = true;
  bool isConfirmPassObscure = true;

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
          labelText: S.of(context).signup_email,
          controller: widget.emailController,
          validator: (value) {
            // if (value!.isEmpty) return S.current.email_required;
            if (value!.isEmpty) {
              return "Email is required";
            }
            if (!AppRegex.isEmailValid(value)) {
              // return S.current.invalid_email;
              return "Invalid email";
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
          labelText: S.of(context).signup_password,
          controller: widget.passwordController,
          isObscureText: isPassObscure,
          suffixIcon: IconButton(
            icon: Icon(
              isPassObscure ? Icons.visibility_off : Icons.visibility,
              color: ColorsManager.accentColor,
            ),
            onPressed: () => setState(() => isPassObscure = !isPassObscure),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              // return S.current.password_required;
              return "Password is required";
            }
            if (!AppRegex.isPasswordValid(value)) {
              // return S.current.invalid_password;
              return "Invalid password";
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
          labelText: S.of(context).signup_confirm_password,
          controller: widget.confirmPasswordController,
          isObscureText: isConfirmPassObscure,
          suffixIcon: IconButton(
            icon: Icon(
              isConfirmPassObscure ? Icons.visibility_off : Icons.visibility,
              color: ColorsManager.accentColor,
            ),
            onPressed: () =>
                setState(() => isConfirmPassObscure = !isConfirmPassObscure),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              // return S.current.confirm_password_required;
              return "Confirm password is required";
            }
            if (value != widget.passwordController.text) {
              // return S.current.password_mismatch;
              return "Password does not match";
            }
            return null;
          },
        ),
      ],
    );
  }
}
