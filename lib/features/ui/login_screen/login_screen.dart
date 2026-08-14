// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../config/di.dart';
// import '../../../core/utlis/app_colors.dart';
// import '../../../core/utlis/app_routes.dart';
// import '../../../core/utlis/app_text.dart';
// import '../../../widget/auth_resauble_widgets/app_branding_header.dart';
// import '../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';
// import '../../../widget/custom_elevated_button.dart';
// import '../../../widget/custom_text_form_field.dart';
// import '../../../widget/toast_bar_message.dart';
// import 'cubit/login_states.dart';
// import 'cubit/login_view_model.dart';
//
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<LoginViewModel>(),
//       child: const _LoginView(),
//     );
//   }
// }
//
// class _LoginView extends StatefulWidget {
//   const _LoginView();
//
//   @override
//   State<_LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<_LoginView> {
//   final _emailController = TextEditingController(
//       text: 'ahmedmostafa@gmail.com');
//   final _passwordController = TextEditingController(text: 'ahmed@512');
//
//   bool _obscurePassword = true;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _submit() {
//     FocusScope.of(context).unfocus();
//     context.read<LoginViewModel>().login(
//       email: _emailController.text.trim(),
//       password: _passwordController.text,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: BlocConsumer<LoginViewModel, LoginStates>(
//         listener: (context, state) {
//           if (state is LoginErrorState) {
//             AppToast.error(context, state.errorMessage);
//           } else if (state is LoginValidationErrorState) {
//             AppToast.warning(context, state.errorMessage);
//           } else if (state is LoginSuccessState) {
//             Navigator.of(context).pushNamedAndRemoveUntil(
//               AppRoutes.mainWrapperScreen,
//                   (route) => false,
//             );
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is LoginLoadingState;
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
//                         'Welcome Back',
//                         style: AppTextStyle.display
//                             .copyWith(color: AppColors.textPrimary),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         'Sign in to continue ordering your favorite meals',
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
//                           text: 'Log In',
//                         ),
//                       ),
//                       SizedBox(height: 90.h),
//                       const _RegisterRow(),
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
// class _RegisterRow extends StatelessWidget {
//   const _RegisterRow();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Don't have an account? ",
//           style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
//         ),
//         GestureDetector(
//           onTap: () =>
//               Navigator.of(context).pushNamed(AppRoutes.registerScreen),
//           child: Text(
//             'Register',
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
import 'cubit/login_states.dart';
import 'cubit/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginViewModel>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController(
      text: 'ahmedmostafa@gmail.com');
  final _passwordController = TextEditingController(text: 'ahmed@512');

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<LoginViewModel>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<LoginViewModel, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            AppToast.error(context, state.errorMessage);
          } else if (state is LoginValidationErrorState) {
            AppToast.warning(context, state.errorMessage);
          } else if (state is LoginSuccessState) {
            // Save the user's email so ProfileScreen can retrieve and render it
            getIt<AuthLocalStorage>().saveUserEmail(
                _emailController.text.trim());
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.mainWrapperScreen,
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoadingState;
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
                        'Welcome Back',
                        style: AppTextStyle.display
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Sign in to continue ordering your favorite meals',
                        style: AppTextStyle.body
                            .copyWith(color: AppColors.textSecondary),
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
                          text: 'Log In',
                        ),
                      ),
                      SizedBox(height: 90.h),
                      const _RegisterRow(),
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

class _RegisterRow extends StatelessWidget {
  const _RegisterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(AppRoutes.registerScreen),
          child: Text(
            'Register',
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