import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';
import '../../../../domain/domain.dart';
import '../../../../domain/models/service_category_model.dart';
import '../../../widgets/base_shimmer.dart';
import '../ads_service_controller.dart';

class CategoriesSelection extends GetView<AdsServiceController> {
  const CategoriesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final data = controller.moduleController.serviceCategories.data.value;

        switch (controller.moduleController.serviceCategories.state.value) {
          case LoadingState.initial:
          case LoadingState.loading:
            return _ListCategory(isLoading: true, data: data);
          case LoadingState.success:
            final dataFiltered = data.filter(
                (e) => controller.allowAppearCategories.contains(e.type));
            return _ListCategory(
              isLoading: false,
              data: [
                ServiceCategoryModel.all(),
                ...dataFiltered,
                ServiceCategoryModel.more()
              ],
              onTap: controller.onTapServiceCategorySelection,
              selected: controller.selectedCategory.value,
            );
          case LoadingState.error:
          case LoadingState.empty:
            return _ListCategory(isLoading: false, data: data);
        }
      },
    );
  }
}

class _ListCategory extends GetView<AdsServiceController> {
  final bool isLoading;
  final List<ServiceCategoryModel> data;
  final Function(ServiceCategoryModel e)? onTap;
  final ServiceCategoryModel? selected;
  const _ListCategory({
    required this.isLoading,
    required this.data,
    this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle itemTextStyle = kTheme.textTheme.bodyMedium!.copyWith(
      color: kTheme.colorScheme.onBackground,
    );
    const EdgeInsetsGeometry itemPadding =
        EdgeInsets.symmetric(horizontal: 10, vertical: 5);
    return SizedBox(
      width: double.infinity,
      height: itemTextStyle.fontSize! + itemPadding.vertical * 2,
      child: isLoading
          ? _LoadingListView(
              data: data,
              itemTextStyle: itemTextStyle,
              itemPadding: itemPadding)
          : _DataListView(
              data: data,
              itemTextStyle: itemTextStyle,
              itemPadding: itemPadding,
              onTap: onTap,
              selected: selected,
            ),
    );
  }
}

class _LoadingListView extends StatelessWidget {
  const _LoadingListView({
    required this.data,
    required this.itemTextStyle,
    required this.itemPadding,
  });

  final List<ServiceCategoryModel> data;
  final TextStyle itemTextStyle;
  final EdgeInsetsGeometry itemPadding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final e = data[index];
        return _Item(
          isLoading: true,
          e: e,
          itemTextStyle: itemTextStyle,
          padding: itemPadding,
        );
      },
      separatorBuilder: (context, index) => kGapW8,
    );
  }
}

class _DataListView extends StatelessWidget {
  const _DataListView({
    required this.data,
    required this.itemTextStyle,
    required this.itemPadding,
    this.selected,
    this.onTap,
  });

  final List<ServiceCategoryModel> data;
  final TextStyle itemTextStyle;
  final EdgeInsetsGeometry itemPadding;
  final Function(ServiceCategoryModel e)? onTap;
  final ServiceCategoryModel? selected;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final e = data[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
              duration: const Duration(milliseconds: 410),
              curve: Curves.decelerate,
              horizontalOffset: 25.0,
              verticalOffset: 0.0,
              child: _Item(
                e: e,
                isLoading: false,
                itemTextStyle: itemTextStyle,
                padding: itemPadding,
                onTap: onTap,
                selected: selected,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => kGapW8,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final bool isLoading;
  final ServiceCategoryModel e;
  final TextStyle itemTextStyle;
  final EdgeInsetsGeometry padding;
  final Function(ServiceCategoryModel e)? onTap;
  final ServiceCategoryModel? selected;
  const _Item({
    required this.isLoading,
    required this.e,
    required this.itemTextStyle,
    required this.padding,
    this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selected == e;
    final Widget child = GestureDetector(
      onTap: () => onTap?.call(e),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 210),
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? kTheme.colorScheme.primary
                : kTheme.colorScheme.onBackground.withOpacity(0.3),
            width: isSelected ? 1.2 : 1,
          ),
        ),
        child: Text(
          e.name,
          style: itemTextStyle.copyWith(
            color: isSelected ? kTheme.colorScheme.primary : null,
          ),
        ),
      ),
    );
    return isLoading ? BaseShimmer(child: child) : child;
  }
}
