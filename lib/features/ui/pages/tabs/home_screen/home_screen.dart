// // import 'package:flutter/material.dart';
// // import 'package:flutter_animate/flutter_animate.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// //
// // import 'package:restaurant_flutter_app/config/di.dart';
// // import 'package:restaurant_flutter_app/core/utlis/app_colors.dart';
// // import 'package:restaurant_flutter_app/core/utlis/app_text.dart';
// // import 'package:restaurant_flutter_app/core/utlis/app_routes.dart';
// // import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_states.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_view_model.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/MainErrorWidget.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/MainLodaingWidget.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/RowOfTextAndViewAll.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/category_filter_chip.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/home_header.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/home_search_bar.dart';
// // import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/restaurant_card.dart';
// //
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   final HomeScreenViewModel viewModel = getIt<HomeScreenViewModel>();
// //
// //   /// null = "All". Pure UI-layer filtering over data the Cubit already
// //   /// emits — no ViewModel/state changes.
// //   String? _selectedType;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     viewModel.getRestaurants();
// //   }
// //
// //   List<String> _typesFrom(List<Restaurant> restaurants) {
// //     final types = restaurants
// //         .map((r) => r.type?.trim())
// //         .where((t) => t != null && t.isNotEmpty)
// //         .cast<String>()
// //         .toSet()
// //         .toList();
// //     types.sort();
// //     return types;
// //   }
// //
// //   List<Restaurant> _filtered(List<Restaurant> restaurants) {
// //     if (_selectedType == null) return restaurants;
// //     return restaurants.where((r) => r.type?.trim() == _selectedType).toList();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.background,
// //       body: SafeArea(
// //         child: BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
// //           bloc: viewModel,
// //           builder: (context, state) {
// //             if (state is HomeScreenLoadingState || state is HomeScreenInitialState) {
// //               return Column(
// //                 children: [
// //                   Padding(
// //                     padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
// //                     child: const HomeHeader(),
// //                   ),
// //                   const Expanded(child: MainLoadingWidget()),
// //                 ],
// //               );
// //             }
// //
// //             if (state is HomeScreenErrorState) {
// //               return Column(
// //                 children: [
// //                   Padding(
// //                     padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
// //                     child: const HomeHeader(),
// //                   ),
// //                   Expanded(
// //                     child: MainErrorWidget(
// //                       errorMessage: state.errorMessage,
// //                       onPressed: viewModel.getRestaurants,
// //                     ),
// //                   ),
// //                 ],
// //               );
// //             }
// //
// //             final restaurants = (state as HomeScreenSuccessState).restaurants;
// //             final types = _typesFrom(restaurants);
// //             final filtered = _filtered(restaurants);
// //
// //             return CustomScrollView(
// //               slivers: [
// //                 SliverPadding(
// //                   padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
// //                   sliver: SliverToBoxAdapter(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const HomeHeader(),
// //                         SizedBox(height: 20.h),
// //                         const HomeSearchBar(),
// //                         if (types.isNotEmpty) ...[
// //                           SizedBox(height: 24.h),
// //                           SizedBox(
// //                             height: 40.h,
// //                             child: ListView.separated(
// //                               scrollDirection: Axis.horizontal,
// //                               itemCount: types.length + 1,
// //                               separatorBuilder: (_, __) => SizedBox(width: 10.w),
// //                               itemBuilder: (context, index) {
// //                                 final value = index == 0 ? null : types[index - 1];
// //                                 return CategoryFilterChip(
// //                                   label: index == 0 ? 'All' : types[index - 1],
// //                                   isSelected: _selectedType == value,
// //                                   onTap: () => setState(() => _selectedType = value),
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                         ],
// //                         SizedBox(height: 24.h),
// //                         RowOfTextAndViewAll(
// //                           title: _selectedType ?? 'All restaurants',
// //                         ),
// //                         SizedBox(height: 14.h),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 if (filtered.isEmpty)
// //                   SliverFillRemaining(
// //                     hasScrollBody: false,
// //                     child: _EmptyState(hasFilter: _selectedType != null),
// //                   )
// //                 else
// //                   SliverPadding(
// //                     padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
// //                     sliver: SliverList.builder(
// //                       itemCount: filtered.length,
// //                       itemBuilder: (context, index) {
// //                         final restaurant = filtered[index];
// //                         return Padding(
// //                           padding: EdgeInsets.only(bottom: 14.h),
// //                           child: RestaurantCard(
// //                             restaurant: restaurant,
// //                             onTap: () => Navigator.of(context).pushNamed(
// //                               AppRoutes.restaurantDetailsScreen,
// //                               arguments: restaurant,
// //                             ),
// //                           )
// //                               .animate()
// //                               .fadeIn(duration: 300.ms, delay: (index * 40).ms)
// //                               .slideY(
// //                             begin: 0.06,
// //                             end: 0,
// //                             duration: 300.ms,
// //                             delay: (index * 40).ms,
// //                             curve: Curves.easeOutCubic,
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //               ],
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class _EmptyState extends StatelessWidget {
// //   final bool hasFilter;
// //
// //   const _EmptyState({required this.hasFilter});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Padding(
// //         padding: EdgeInsets.symmetric(horizontal: 32.w),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Icon(Icons.restaurant_menu_rounded, size: 48.sp, color: AppColors.textTertiary),
// //             SizedBox(height: 12.h),
// //             Text(
// //               hasFilter ? 'No restaurants match this category' : 'No restaurants available right now',
// //               textAlign: TextAlign.center,
// //               style: AppTextStyle.subtitle.copyWith(color: AppColors.textSecondary),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:restaurant_flutter_app/config/di.dart';
// import 'package:restaurant_flutter_app/core/utlis/app_colors.dart';
// import 'package:restaurant_flutter_app/core/utlis/app_routes.dart';
// import 'package:restaurant_flutter_app/core/utlis/app_text.dart';
// import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_states.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_view_model.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/MainErrorWidget.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/MainLodaingWidget.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/RowOfTextAndViewAll.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/category_filter_chip.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/home_header.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/home_search_bar.dart';
// import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/restaurant_card.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final HomeScreenViewModel viewModel = getIt<HomeScreenViewModel>();
//
//   /// null = "All". Pure UI-layer filtering over data the Cubit already
//   /// emits — no ViewModel/state changes.
//   String? _selectedType;
//
//   @override
//   void initState() {
//     super.initState();
//     viewModel.getRestaurants();
//   }
//
//   List<String> _typesFrom(List<Restaurant> restaurants) {
//     final types = restaurants
//         .map((r) => r.type?.trim())
//         .where((t) => t != null && t.isNotEmpty)
//         .cast<String>()
//         .toSet()
//         .toList();
//     types.sort();
//     return types;
//   }
//
//   List<Restaurant> _filtered(List<Restaurant> restaurants) {
//     if (_selectedType == null) return restaurants;
//     return restaurants.where((r) => r.type?.trim() == _selectedType).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
//           bloc: viewModel,
//           builder: (context, state) {
//             if (state is HomeScreenLoadingState || state is HomeScreenInitialState) {
//               return Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
//                     child: const HomeHeader(),
//                   ),
//                   const Expanded(child: MainLoadingWidget()),
//                 ],
//               );
//             }
//
//             if (state is HomeScreenErrorState) {
//               return Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
//                     child: const HomeHeader(),
//                   ),
//                   Expanded(
//                     child: MainErrorWidget(
//                       errorMessage: state.errorMessage,
//                       onPressed: viewModel.getRestaurants,
//                     ),
//                   ),
//                 ],
//               );
//             }
//
//             final restaurants = (state as HomeScreenSuccessState).restaurants;
//             final types = _typesFrom(restaurants);
//             final filtered = _filtered(restaurants);
//
//             return CustomScrollView(
//               physics: const BouncingScrollPhysics(),
//               slivers: [
//                 // Top Section: Header & Search
//                 SliverPadding(
//                   padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
//                   sliver: SliverToBoxAdapter(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const HomeHeader(),
//                         SizedBox(height: 20.h),
//                         const HomeSearchBar(),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Category Chips (Horizontal Edge-to-Edge Scroll)
//                 if (types.isNotEmpty) ...[
//                   SliverToBoxAdapter(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 20.h),
//                         SizedBox(
//                           height: 42.h,
//                           child: ListView.separated(
//                             physics: const BouncingScrollPhysics(),
//                             scrollDirection: Axis.horizontal,
//                             padding: EdgeInsets.symmetric(horizontal: 20.w),
//                             itemCount: types.length + 1,
//                             separatorBuilder: (_, __) => SizedBox(width: 8.w),
//                             itemBuilder: (context, index) {
//                               final value = index == 0 ? null : types[index - 1];
//                               return CategoryFilterChip(
//                                 label: index == 0 ? 'All' : types[index - 1],
//                                 isSelected: _selectedType == value,
//                                 onTap: () => setState(() => _selectedType = value),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//
//                 // Section Title: Selected Category
//                 SliverPadding(
//                   padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 14.h),
//                   sliver: SliverToBoxAdapter(
//                     child: RowOfTextAndViewAll(
//                       title: _selectedType ?? 'All restaurants',
//                     ),
//                   ),
//                 ),
//
//                 // Main Restaurant List / Empty State
//                 if (filtered.isEmpty)
//                   SliverFillRemaining(
//                     hasScrollBody: false,
//                     child: _EmptyState(hasFilter: _selectedType != null),
//                   )
//                 else
//                   SliverPadding(
//                     padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
//                     sliver: SliverList.builder(
//                       itemCount: filtered.length,
//                       itemBuilder: (context, index) {
//                         final restaurant = filtered[index];
//                         return Padding(
//                           padding: EdgeInsets.only(bottom: 16.h),
//                           child: RestaurantCard(
//                             restaurant: restaurant,
//                             onTap: () => Navigator.of(context).pushNamed(
//                               AppRoutes.restaurantDetailsScreen,
//                               arguments: restaurant,
//                             ),
//                           )
//                               .animate()
//                               .fadeIn(
//                             duration: 350.ms,
//                             delay: (index * 50).ms,
//                             curve: Curves.easeOut,
//                           )
//                               .slideY(
//                             begin: 0.08,
//                             end: 0,
//                             duration: 350.ms,
//                             delay: (index * 50).ms,
//                             curve: Curves.easeOutCubic,
//                           )
//                               .scaleXY(
//                             begin: 0.98,
//                             end: 1.0,
//                             duration: 350.ms,
//                             delay: (index * 50).ms,
//                             curve: Curves.easeOutCubic,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class _EmptyState extends StatelessWidget {
//   final bool hasFilter;
//
//   const _EmptyState({required this.hasFilter});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.h),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 88.r,
//               height: 88.r,
//               decoration: BoxDecoration(
//                 color: AppColors.textTertiary.withOpacity(0.08),
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.restaurant_menu_rounded,
//                   size: 42.sp,
//                   color: AppColors.textTertiary,
//                 ),
//               ),
//             )
//                 .animate(onPlay: (controller) => controller.repeat(reverse: true))
//                 .scaleXY(begin: 0.95, end: 1.05, duration: 1500.ms, curve: Curves.easeInOut),
//             SizedBox(height: 20.h),
//             Text(
//               hasFilter ? 'No Matches Found' : 'No Restaurants Available',
//               textAlign: TextAlign.center,
//               style: AppTextStyle.subtitle.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textSecondary,
//               ),
//             ),
//             SizedBox(height: 6.h),
//             Text(
//               hasFilter
//                   ? 'Try selecting a different category filter above.'
//                   : 'Check back later for updates in your area.',
//               textAlign: TextAlign.center,
//               style: AppTextStyle.subtitle.copyWith(
//                 fontSize: 13.sp,
//                 color: AppColors.textTertiary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_flutter_app/config/di.dart';
import 'package:restaurant_flutter_app/core/utlis/app_colors.dart';
import 'package:restaurant_flutter_app/core/utlis/app_routes.dart';
import 'package:restaurant_flutter_app/core/utlis/app_text.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_states.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_view_model.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/MainErrorWidget.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/MainLodaingWidget.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/RowOfTextAndViewAll.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/category_filter_chip.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/home_header.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/home_search_bar.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/widget/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenViewModel viewModel = getIt<HomeScreenViewModel>();

  /// null = "All". Pure UI-layer filtering over data the Cubit already
  /// emits — no ViewModel/state changes.
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    viewModel.getRestaurants();
  }

  List<String> _typesFrom(List<Restaurant> restaurants) {
    final types = restaurants
        .map((r) => r.type?.trim())
        .where((t) => t != null && t.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();
    types.sort();
    return types;
  }

  List<Restaurant> _filtered(List<Restaurant> restaurants) {
    if (_selectedType == null) return restaurants;
    return restaurants.where((r) => r.type?.trim() == _selectedType).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is HomeScreenLoadingState ||
                state is HomeScreenInitialState) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
                    child: const HomeHeader(),
                  ),
                  const Expanded(child: MainLoadingWidget()),
                ],
              );
            }

            if (state is HomeScreenErrorState) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                    child: const HomeHeader(),
                  ),
                  Expanded(
                    child: MainErrorWidget(
                      errorMessage: state.errorMessage,
                      onPressed: viewModel.getRestaurants,
                    ),
                  ),
                ],
              );
            }

            final restaurants = (state as HomeScreenSuccessState).restaurants;
            final types = _typesFrom(restaurants);
            final filtered = _filtered(restaurants);

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Top Section: Header & Search
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomeHeader(),
                        SizedBox(height: 20.h),
                        const HomeSearchBar(),
                      ],
                    ),
                  ),
                ),

                // Category Chips (Horizontal Edge-to-Edge Scroll)
                if (types.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 42.h,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: types.length + 1,
                            separatorBuilder: (_, __) => SizedBox(width: 8.w),
                            itemBuilder: (context, index) {
                              final value = index == 0 ? null : types[index -
                                  1];
                              return CategoryFilterChip(
                                label: index == 0 ? 'All' : types[index - 1],
                                isSelected: _selectedType == value,
                                onTap: () =>
                                    setState(() => _selectedType = value),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Section Title: Selected Category
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 14.h),
                  sliver: SliverToBoxAdapter(
                    child: RowOfTextAndViewAll(
                      title: _selectedType ?? 'All restaurants',
                    ),
                  ),
                ),

                // Main Restaurant List / Empty State
                if (filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyState(hasFilter: _selectedType != null),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                    sliver: SliverList.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final restaurant = filtered[index];

                        // Capped stagger delay so scrolling items render instantly
                        final staggerDelay = ((index % 4) * 30).ms;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: RestaurantCard(
                            key: ValueKey(restaurant.restaurantName ?? index),
                            restaurant: restaurant,
                            onTap: () =>
                                Navigator.of(context).pushNamed(
                                  AppRoutes.restaurantDetailsScreen,
                                  arguments: restaurant,
                                ),
                          )
                              .animate()
                              .fadeIn(
                            duration: 200.ms,
                            delay: staggerDelay,
                            curve: Curves.easeOut,
                          )
                              .slideY(
                            begin: 0.05,
                            end: 0,
                            duration: 200.ms,
                            delay: staggerDelay,
                            curve: Curves.easeOutCubic,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool hasFilter;

  const _EmptyState({required this.hasFilter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88.r,
              height: 88.r,
              decoration: BoxDecoration(
                color: AppColors.textTertiary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.restaurant_menu_rounded,
                  size: 42.sp,
                  color: AppColors.textTertiary,
                ),
              ),
            )
                .animate(
                onPlay: (controller) => controller.repeat(reverse: true))
                .scaleXY(begin: 0.95,
                end: 1.05,
                duration: 1500.ms,
                curve: Curves.easeInOut),
            SizedBox(height: 20.h),
            Text(
              hasFilter ? 'No Matches Found' : 'No Restaurants Available',
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              hasFilter
                  ? 'Try selecting a different category filter above.'
                  : 'Check back later for updates in your area.',
              textAlign: TextAlign.center,
              style: AppTextStyle.subtitle.copyWith(
                fontSize: 13.sp,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}