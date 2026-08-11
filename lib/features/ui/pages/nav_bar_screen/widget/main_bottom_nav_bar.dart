import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utlis/app_colors.dart';
import '../../../../../core/utlis/app_text.dart';

/// Floating bottom navigation bar with fluid `flutter_animate` effects.
class MainBottomNavBar extends StatelessWidget {
  final List<String> icons;
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const MainBottomNavBar({
    super.key,
    required this.icons,
    required this.labels,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: 12.h),
        child: Container(
          height: 72.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withValues(alpha: 0.10),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: AppColors.secondary.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / icons.length;

              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // 1. Sliding Pill with Bounce & Shimmer on Tab Selection
                  AnimatedPositioned(
                    duration: 350.ms,
                    curve: Curves.easeOutBack,
                    left: itemWidth * selectedIndex + (itemWidth - 62.w) / 2,
                    top: (72.h - 58.h) / 2,
                    child:
                        Container(
                              width: 62.w,
                              height: 58.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22.r),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primaryDark,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.38,
                                    ),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                            )
                            // Trigger pop scale + subtle light shimmer whenever tab changes
                            .animate(key: ValueKey(selectedIndex))
                            .scale(
                              begin: const Offset(0.82, 0.82),
                              end: const Offset(1.0, 1.0),
                              duration: 400.ms,
                              curve: Curves.easeOutBack,
                            )
                            .shimmer(
                              delay: 120.ms,
                              duration: 700.ms,
                              color: Colors.white24,
                            ),
                  ),

                  // 2. Interactive Navigation Items
                  Row(
                    children: List.generate(icons.length, (index) {
                      final isActive = index == selectedIndex;
                      return SizedBox(
                        width: itemWidth,
                        child: _NavItem(
                          iconPath: icons[index],
                          label: labels[index],
                          isActive: isActive,
                          onTap: () {
                            if (!isActive) {
                              HapticFeedback.lightImpact();
                              onTap(index);
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final contentColor = isActive ? AppColors.surface : AppColors.textTertiary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        splashColor: AppColors.primary.withValues(alpha: 0.12),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with spring scale & slight vertical elevation when active
              ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      contentColor,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(iconPath, width: 22.w, height: 22.w),
                  )
                  .animate(target: isActive ? 1 : 0)
                  .scaleXY(
                    begin: 0.9,
                    end: 1.15,
                    duration: 300.ms,
                    curve: Curves.easeOutBack,
                  )
                  .moveY(
                    begin: 0,
                    end: -1.5,
                    duration: 300.ms,
                    curve: Curves.easeOutCubic,
                  ),

              SizedBox(height: 3.h),

              // Text label with smooth pop & opacity target transition
              Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.caption.copyWith(
                      color: contentColor,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      fontSize: 11.sp,
                    ),
                  )
                  .animate(target: isActive ? 1 : 0)
                  .scaleXY(
                    begin: 0.95,
                    end: 1.05,
                    duration: 250.ms,
                    curve: Curves.easeOut,
                  )
                  .fade(begin: 0.7, end: 1.0, duration: 250.ms),
            ],
          ),
        ),
      ),
    );
  }
}
