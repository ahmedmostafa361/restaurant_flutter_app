import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/search_screen/widget/item_search_result_card.dart';
import 'package:restaurant_flutter_app/widget/resuable_cache_lottie.dart';

import '../../../../../config/di.dart';
import '../../../../../core/utlis/app_colors.dart';
import '../../../../../core/utlis/app_routes.dart';
import '../../../../../core/utlis/app_text.dart';
import '../../../../../domain/entinties/request/cart_item.dart';
import '../../../../../domain/entinties/response/menu/menu_item.dart';
import '../../../../../domain/entinties/response/restaurants/restaurant.dart';
import '../../../../../widget/toast_bar_message.dart';
import '../../cart_screen/cubit/cart_view_model.dart';
import 'cubit/search_states.dart';
import 'cubit/search_view_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchViewModel>(),
      child: const _SearchView(),
    );
  }
}

/// test for ci cdggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg
class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Screen's whole purpose is searching — autofocus is appropriate here,
    // unlike a general-purpose screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clear(BuildContext context) {
    _controller.clear();
    context.read<SearchViewModel>().onSearchQueryChanged('');
  }

  Future<void> _addToCart(BuildContext context, MenuItem item) async {
    final cart = getIt<CartViewModel>();
    final targetRestaurantId = item.restaurantID!;

    final isSwitchingRestaurant =
        cart.currentRestaurantId != null &&
            cart.currentRestaurantId != targetRestaurantId;

    if (isSwitchingRestaurant) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) =>
            AlertDialog(
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              title: Text('Start a new order?',
                  style: AppTextStyle.title.copyWith(
                      color: AppColors.textPrimary)),
              content: Text(
                'Your cart contains items from another restaurant. Adding this item will clear your existing order.',
                style: AppTextStyle.body.copyWith(
                    color: AppColors.textSecondary),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: Text('Cancel', style: AppTextStyle.label.copyWith(
                      color: AppColors.textSecondary)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, true),
                  child: Text('Start new order',
                      style: AppTextStyle.label.copyWith(
                          color: AppColors.primary)),
                ),
              ],
            ),
      );
      if (confirmed != true) return;
    }

    if (!context.mounted) return;

    cart.addItem(
      CartItem(
        itemName: item.itemName!,
        itemPrice: item.itemPrice!,
        quantity: 1,
        imageUrl: item.imageUrl,
      ),
      restaurantId: targetRestaurantId,
    );
    AppToast.success(context, '${item.itemName} added to cart');
  }

  void _openRestaurant(BuildContext context, MenuItem item) {
    if (item.restaurantID == null) return;
    Navigator.of(context).pushNamed(
      AppRoutes.restaurantDetailsScreen,
      // Only the fields we actually know are populated — RestaurantDetailsScreen
      // re-fetches full details itself, this is just the fallback/display seed.
      arguments: Restaurant(
        restaurantID: item.restaurantID,
        restaurantName: item.restaurantName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _SearchHeader(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (query) =>
                  context.read<SearchViewModel>().onSearchQueryChanged(query),
              onClear: () => _clear(context),
            ),
            Expanded(
              child: BlocBuilder<SearchViewModel, SearchStates>(
                builder: (context, state) {
                  if (state is SearchInitialState) {
                    return const _InitialSearchView();
                  }
                  if (state is SearchLoadingState) {
                    return const _ResultsSkeleton();
                  }
                  if (state is SearchErrorState) {
                    return _ErrorView(message: state.errorMessage);
                  }
                  if (state is SearchEmptyState) {
                    return const _NoResultsView();
                  }

                  final items = (state as SearchSuccessState).items;

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: ListView.separated(
                      key: ValueKey(items.length),
                      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final canAdd = item.restaurantID != null &&
                            item.itemName != null &&
                            item.itemPrice != null;

                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 200 + (index * 30)),
                          builder: (context, value, child) =>
                              Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, (1 - value) * 10),
                                  child: child,
                                ),
                              ),
                          child: ItemSearchResultCard(
                            item: item,
                            onTap: () => _openRestaurant(context, item),
                            onAdd: canAdd
                                ? () => _addToCart(context, item)
                                : null,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchHeader({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 20.w, 12.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            customBorder: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Icon(
                  Icons.arrow_back_rounded, color: AppColors.textPrimary,
                  size: 22.sp),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: focusNode.hasFocus ? AppColors.primary : AppColors
                      .border,
                  width: focusNode.hasFocus ? 1.5 : 1,
                ),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: onChanged,
                textInputAction: TextInputAction.search,
                style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search for food or dishes',
                  hintStyle: AppTextStyle.body.copyWith(
                      color: AppColors.textTertiary),
                  prefixIcon: Icon(
                      Icons.search_rounded, color: AppColors.textSecondary,
                      size: 20.sp),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (context, value, _) {
                      if (value.text.isEmpty) return const SizedBox.shrink();
                      return IconButton(
                        onPressed: onClear,
                        icon: Icon(Icons.close_rounded, color: AppColors
                            .textSecondary, size: 18.sp),
                      );
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 14.h, horizontal: 12.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InitialSearchView extends StatelessWidget {
  const _InitialSearchView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 230.h,
                child: CachedLottie(
                    url: 'https://lottie.host/3bca594e-850c-4008-8f65-6e0b41324694/dOu9WiQ4xO.json')
            ),
            SizedBox(height: 14.h),
            Text('Find your next meal', style: AppTextStyle.title.copyWith(
                color: AppColors.textPrimary)),
            SizedBox(height: 6.h),
            Text(
              'Search for dishes across all restaurants.',
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoResultsView extends StatelessWidget {
  const _NoResultsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 280.h,
                child: CachedLottie(
                    url: 'https://lottie.host/6ab1889c-1f58-4818-9f8d-33c631f75315/wD5gMCkiFu.json'
                )
            ),
            SizedBox(height: 12.h),
            Text('No dishes found', style: AppTextStyle.title.copyWith(
                color: AppColors.textPrimary)),
            SizedBox(height: 6.h),
            Text(
              'Try a different search term.',
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 40.sp,
                color: AppColors.error),
            SizedBox(height: 12.h),
            Text(message, textAlign: TextAlign.center,
                style: AppTextStyle.body.copyWith(
                    color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _ResultsSkeleton extends StatelessWidget {
  const _ResultsSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, __) => _ShimmerBar(height: 100.h),
    );
  }
}

class _ShimmerBar extends StatefulWidget {
  final double height;
  const _ShimmerBar({required this.height});

  @override
  State<_ShimmerBar> createState() => _ShimmerBarState();
}

class _ShimmerBarState extends State<_ShimmerBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) =>
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: Color.lerp(
                  AppColors.divider, AppColors.border, _controller.value),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
    );
  }
}