// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../config/di.dart';
// import '../../../core/cache_save_data/auth_local_storage.dart';
// import '../../../core/utlis/app_colors.dart';
// import '../../../core/utlis/app_routes.dart';
// import '../../../core/utlis/app_text.dart';
// import '../../../widget/auth_resauble_widgets/app_branding_header.dart';
// import '../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';
// import '../../../widget/custom_elevated_button.dart';
// import '../../../widget/custom_text_form_field.dart';
// import '../../../widget/toast_bar_message.dart';
// import 'cubit/register_state.dart';
// import 'cubit/register_view_model.dart';
//
// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<RegisterViewModel>(),
//       child: const _RegisterView(),
//     );
//   }
// }
//
// class _RegisterView extends StatefulWidget {
//   const _RegisterView();
//
//   @override
//   State<_RegisterView> createState() => _RegisterViewState();
// }
//
// class _RegisterViewState extends State<_RegisterView> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _submit() {
//     FocusScope.of(context).unfocus();
//     context.read<RegisterViewModel>().register(
//       email: _emailController.text.trim(),
//       password: _passwordController.text,
//       confirmPassword: _confirmPasswordController.text,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: BlocConsumer<RegisterViewModel, RegisterStates>(
//         listener: (context, state) {
//           if (state is RegisterErrorState) {
//             AppToast.error(context, state.errorMessage);
//           } else if (state is RegisterValidationErrorState) {
//             AppToast.warning(context, state.errorMessage);
//           } else if (state is RegisterSuccessState) {
//             AppToast.success(context, 'Account created — please sign in.');
//             Navigator.of(context).pushNamedAndRemoveUntil(
//               AppRoutes.loginScreen,
//                   (route) => false,
//             );
//           }else if (state is RegisterSuccessState) {
//             getIt<AuthLocalStorage>().saveUserEmail(_emailController.text.trim());
//             AppToast.success(context, 'Account created — please sign in.');
//             Navigator.of(context).pushNamedAndRemoveUntil(
//               AppRoutes.loginScreen,
//                   (route) => false,
//             );
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is RegisterLoadingState;
//           return SafeArea(
//             child: GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () => FocusScope.of(context).unfocus(),
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
//                 child: FadeSlideEntrance(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const AppBrandingHeader(),
//                       SizedBox(height: 40.h),
//                       Text(
//                         'Create Account',
//                         style: AppTextStyle.display
//                             .copyWith(color: AppColors.textPrimary),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         'Sign up to start ordering your favorite meals',
//                         style: AppTextStyle.body
//                             .copyWith(color: AppColors.textSecondary),
//                       ),
//                       SizedBox(height: 36.h),
//                       CustomTextFormField(
//                         controller: _emailController,
//                         hintText: 'Email address',
//                         keyboardType: TextInputType.emailAddress,
//                         textInputAction: TextInputAction.next,
//                         prefixIcon: Icon(
//                           Icons.mail_outline_rounded,
//                           color: AppColors.textSecondary,
//                           size: 20.sp,
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       CustomTextFormField(
//                         controller: _passwordController,
//                         hintText: 'Password',
//                         obscureText: _obscurePassword,
//                         textInputAction: TextInputAction.next,
//                         prefixIcon: Icon(
//                           Icons.lock_outline_rounded,
//                           color: AppColors.textSecondary,
//                           size: 20.sp,
//                         ),
//                         suffixIcon: IconButton(
//                           onPressed: () =>
//                               setState(
//                                     () => _obscurePassword = !_obscurePassword,
//                               ),
//                           icon: AnimatedSwitcher(
//                             duration: const Duration(milliseconds: 200),
//                             transitionBuilder: (child, anim) =>
//                                 FadeTransition(opacity: anim, child: child),
//                             child: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off_rounded
//                                   : Icons.visibility_rounded,
//                               key: ValueKey(_obscurePassword),
//                               color: AppColors.textSecondary,
//                               size: 20.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                       CustomTextFormField(
//                         controller: _confirmPasswordController,
//                         hintText: 'Confirm password',
//                         obscureText: _obscureConfirmPassword,
//                         textInputAction: TextInputAction.done,
//                         onFieldSubmitted: (_) => _submit(),
//                         prefixIcon: Icon(
//                           Icons.lock_outline_rounded,
//                           color: AppColors.textSecondary,
//                           size: 20.sp,
//                         ),
//                         suffixIcon: IconButton(
//                           onPressed: () =>
//                               setState(
//                                     () =>
//                                 _obscureConfirmPassword =
//                                 !_obscureConfirmPassword,
//                               ),
//                           icon: AnimatedSwitcher(
//                             duration: const Duration(milliseconds: 200),
//                             transitionBuilder: (child, anim) =>
//                                 FadeTransition(opacity: anim, child: child),
//                             child: Icon(
//                               _obscureConfirmPassword
//                                   ? Icons.visibility_off_rounded
//                                   : Icons.visibility_rounded,
//                               key: ValueKey(_obscureConfirmPassword),
//                               color: AppColors.textSecondary,
//                               size: 20.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 28.h),
//                       SizedBox(
//                         height: 54.h,
//                         child: CustomElevatedButton(
//                           onPressed: isLoading ? null : _submit,
//                           hasIcon: isLoading,
//                           customInButton: SizedBox(
//                             width: 22.w,
//                             height: 22.w,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2.4,
//                               color: AppColors.surface,
//                             ),
//                           ),
//                           text: 'Create Account',
//                         ),
//                       ),
//                       SizedBox(height: 90.h),
//                       const _LoginRow(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _LoginRow extends StatelessWidget {
//   const _LoginRow();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'Already have an account? ',
//           style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
//         ),
//         GestureDetector(
//           onTap: () => Navigator.of(context).pop(),
//           child: Text(
//             'Log In',
//             style: AppTextStyle.body.copyWith(
//               color: AppColors.primary,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/di.dart';
import '../../../core/cache_save_data/auth_local_storage.dart';
import '../../../core/utlis/app_colors.dart';
import '../../../core/utlis/app_routes.dart';
import '../../../core/utlis/app_text.dart';
import '../../../widget/auth_resauble_widgets/app_branding_header.dart';
import '../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_text_form_field.dart';
import '../../../widget/toast_bar_message.dart';
import 'cubit/register_state.dart';
import 'cubit/register_view_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterViewModel>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<RegisterViewModel>().register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<RegisterViewModel, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            AppToast.error(context, state.errorMessage);
          } else if (state is RegisterValidationErrorState) {
            AppToast.warning(context, state.errorMessage);
          } else if (state is RegisterSuccessState) {
            getIt<AuthLocalStorage>().saveUserEmail(
                _emailController.text.trim());
            AppToast.success(context, 'Account created — please sign in.');
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.loginScreen,
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoadingState;
          return SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 24.h),
                child: FadeSlideEntrance(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AppBrandingHeader(),
                      SizedBox(height: 40.h),
                      Text(
                        'Create Account',
                        style: AppTextStyle.display.copyWith(color: AppColors
                            .textPrimary),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Sign up to start ordering your favorite meals',
                        style: AppTextStyle.body.copyWith(color: AppColors
                            .textSecondary),
                      ),
                      SizedBox(height: 36.h),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Email address',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icon(
                          Icons.mail_outline_rounded,
                          color: AppColors.textSecondary,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.textSecondary,
                          size: 20.sp,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(
                                    () => _obscurePassword = !_obscurePassword,
                              ),
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, anim) =>
                                FadeTransition(opacity: anim, child: child),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              key: ValueKey(_obscurePassword),
                              color: AppColors.textSecondary,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm password',
                        obscureText: _obscureConfirmPassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.textSecondary,
                          size: 20.sp,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(
                                    () =>
                                _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                              ),
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, anim) =>
                                FadeTransition(opacity: anim, child: child),
                            child: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              key: ValueKey(_obscureConfirmPassword),
                              color: AppColors.textSecondary,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 28.h),
                      SizedBox(
                        height: 54.h,
                        child: CustomElevatedButton(
                          onPressed: isLoading ? null : _submit,
                          hasIcon: isLoading,
                          customInButton: SizedBox(
                            width: 22.w,
                            height: 22.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: AppColors.surface,
                            ),
                          ),
                          text: 'Create Account',
                        ),
                      ),
                      SizedBox(height: 90.h),
                      const _LoginRow(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginRow extends StatelessWidget {
  const _LoginRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Text(
            'Log In',
            style: AppTextStyle.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

/// test for ci cd