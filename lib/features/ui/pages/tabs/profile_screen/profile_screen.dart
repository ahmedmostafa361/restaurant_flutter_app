// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../config/di.dart';
// import '../../../../../core/cache_save_data/auth_local_storage.dart';
// import '../../../../../core/utlis/app_colors.dart';
// import '../../../../../core/utlis/app_routes.dart';
// import '../../../../../core/utlis/app_text.dart';
// import '../../../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? _userCode;
//   String? _userEmail;
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }
//
//   Future<void> _loadUser() async {
//     final storage = getIt<AuthLocalStorage>();
//     final code = await storage.getUserCode();
//     final email = await storage.getUserEmail();
//     if (!mounted) return;
//     setState(() {
//       _userCode = (code != null && code.trim().isNotEmpty) ? code : null;
//       _userEmail = (email != null && email.trim().isNotEmpty) ? email : null;
//       _loading = false;
//     });
//   }
//
//   Future<void> _confirmLogout(BuildContext context) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         backgroundColor: AppColors.surface,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//         title: Text('Log out?', style: AppTextStyle.title.copyWith(color: AppColors.textPrimary)),
//         content: Text(
//           'You\'ll need to sign in again to place new orders.',
//           style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, false),
//             child: Text('Cancel', style: AppTextStyle.label.copyWith(color: AppColors.textSecondary)),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext, true),
//             child: Text('Log out', style: AppTextStyle.label.copyWith(color: AppColors.error)),
//           ),
//         ],
//       ),
//     );
//
//     if (confirmed != true || !context.mounted) return;
//
//     final storage = getIt<AuthLocalStorage>();
//     await storage.clearUserCode();
//     await storage.clearUserEmail();
//
//     if (!context.mounted) return;
//     Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: _loading
//             ? const SizedBox.shrink()
//             : FadeSlideEntrance(
//           child: ListView(
//             padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
//             children: [
//               Text('Profile', style: AppTextStyle.headline.copyWith(color: AppColors.textPrimary)),
//               SizedBox(height: 24.h),
//               _ProfileHeader(userCode: _userCode, userEmail: _userEmail),
//               SizedBox(height: 28.h),
//               _ProfileActionTile(
//                 icon: Icons.receipt_long_rounded,
//                 label: 'My Orders',
//                 onTap: () => Navigator.of(context).pushNamed(AppRoutes.ordersScreen),
//               ),
//               SizedBox(height: 12.h),
//               _ProfileActionTile(
//                 icon: Icons.logout_rounded,
//                 label: 'Log out',
//                 iconColor: AppColors.error,
//                 labelColor: AppColors.error,
//                 onTap: () => _confirmLogout(context),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _ProfileHeader extends StatelessWidget {
//   final String? userCode;
//   final String? userEmail;
//
//   const _ProfileHeader({required this.userCode, required this.userEmail});
//
//   @override
//   Widget build(BuildContext context) {
//     // Fallback avatar initial: prefer email's first letter, else user code's.
//     final initialSource = userEmail ?? userCode;
//     final initial = (initialSource != null && initialSource.isNotEmpty)
//         ? initialSource[0].toUpperCase()
//         : '?';
//
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: AppColors.card,
//         borderRadius: BorderRadius.circular(20.r),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 76.w,
//             height: 76.w,
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.primary.withValues(alpha: 0.25),
//                   blurRadius: 16,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               initial,
//               style: AppTextStyle.display.copyWith(color: AppColors.surface),
//             ),
//           ),
//           SizedBox(height: 14.h),
//           if (userEmail != null)
//             Text(
//               userEmail!,
//               style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             )
//           else
//             Text(
//               'Signed in',
//               style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
//             ),
//           if (userCode != null) ...[
//             SizedBox(height: 4.h),
//             Text(
//               'User code: $userCode',
//               style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
//
// class _ProfileActionTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final Color? iconColor;
//   final Color? labelColor;
//
//   const _ProfileActionTile({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.iconColor,
//     this.labelColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(14.r),
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//           decoration: BoxDecoration(
//             color: AppColors.card,
//             borderRadius: BorderRadius.circular(14.r),
//             border: Border.all(color: AppColors.border),
//           ),
//           child: Row(
//             children: [
//               Icon(icon, size: 20.sp, color: iconColor ?? AppColors.textSecondary),
//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Text(
//                   label,
//                   style: AppTextStyle.subtitle.copyWith(color: labelColor ?? AppColors.textPrimary),
//                 ),
//               ),
//               Icon(Icons.chevron_right_rounded, size: 18.sp, color: AppColors.textTertiary),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/di.dart';
import '../../../../../core/cache_save_data/auth_local_storage.dart';
import '../../../../../core/utlis/app_colors.dart';
import '../../../../../core/utlis/app_routes.dart';
import '../../../../../core/utlis/app_text.dart';
import '../../../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _userCode;
  String? _userEmail;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final storage = getIt<AuthLocalStorage>();
    final code = await storage.getUserCode();
    final email = await storage.getUserEmail();
    if (!mounted) return;
    setState(() {
      _userCode = (code != null && code
          .trim()
          .isNotEmpty) ? code : null;
      _userEmail = (email != null && email
          .trim()
          .isNotEmpty) ? email : null;
      _loading = false;
    });
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) =>
          AlertDialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            title: Text('Log out?', style: AppTextStyle.title.copyWith(
                color: AppColors.textPrimary)),
            content: Text(
              'You\'ll need to sign in again to place new orders.',
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text('Cancel', style: AppTextStyle.label.copyWith(
                    color: AppColors.textSecondary)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text('Log out',
                    style: AppTextStyle.label.copyWith(color: AppColors.error)),
              ),
            ],
          ),
    );

    if (confirmed != true || !context.mounted) return;

    final storage = getIt<AuthLocalStorage>();
    await storage.clearAll();

    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.loginScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _loading
            ? const SizedBox.shrink()
            : FadeSlideEntrance(
          child: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
            children: [
              Text('Profile', style: AppTextStyle.headline.copyWith(
                  color: AppColors.textPrimary)),
              SizedBox(height: 24.h),
              _ProfileHeader(userCode: _userCode, userEmail: _userEmail),
              SizedBox(height: 28.h),
              _ProfileActionTile(
                icon: Icons.receipt_long_rounded,
                label: 'My Orders',
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.ordersScreen,),
              ),
              SizedBox(height: 12.h),
              _ProfileActionTile(
                icon: Icons.logout_rounded,
                label: 'Log out',
                iconColor: AppColors.error,
                labelColor: AppColors.error,
                onTap: () => _confirmLogout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String? userCode;
  final String? userEmail;

  const _ProfileHeader({required this.userCode, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final initialSource = userEmail ?? userCode;
    final initial = (initialSource != null && initialSource.isNotEmpty)
        ? initialSource[0].toUpperCase()
        : '?';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 76.w,
            height: 76.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(initial,
                style: AppTextStyle.display.copyWith(color: AppColors.surface)),
          ),
          SizedBox(height: 14.h),
          Text(
            userEmail ?? 'Signed in',
            style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (userCode != null) ...[
            SizedBox(height: 4.h),
            Text(
              'User code: $userCode',
              style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (userEmail != null) ...[
            SizedBox(height: 16.h),
            Divider(color: AppColors.divider, height: 1),
            SizedBox(height: 16.h),
            _InfoRow(label: 'Email', value: userEmail!),
            SizedBox(height: 10.h),
            // Not a real password field — masked placeholder only, since
            // the app never stores or has access to the raw password.
            _InfoRow(label: 'Password', value: '••••••••'),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.textSecondary)),
        Flexible(
          child: Text(
            value,
            style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  const _ProfileActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20.sp,
                  color: iconColor ?? AppColors.textSecondary),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyle.subtitle.copyWith(
                      color: labelColor ?? AppColors.textPrimary),
                ),
              ),
              Icon(Icons.chevron_right_rounded, size: 18.sp,
                  color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}