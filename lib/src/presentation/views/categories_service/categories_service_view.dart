import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/core.dart';

import '../../../domain/domain.dart';
import '../../../domain/models/service_category_model.dart';
import '../../widgets/base_shimmer.dart';
import 'categories_service_controller.dart';

class CategoriesServiceView extends StatelessWidget {
  const CategoriesServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesServiceController>(
      init: CategoriesServiceController(),
      builder: (_) {
        return const Material(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _MainViewBuilder(),
            ),
          ),
        );
      },
    );
  }
}

class _MainViewBuilder extends GetView<CategoriesServiceController> {
  const _MainViewBuilder();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.moduleController.serviceCategories.data.value;
      switch (controller.moduleController.serviceCategories.state.value) {
        case LoadingState.initial:
        case LoadingState.loading:
          return _ListServiceCategory(isLoading: true, data: data);
        case LoadingState.success:
          return _ListServiceCategory(isLoading: false, data: data);
        case LoadingState.error:
        case LoadingState.empty:
          return _ListServiceCategory(isLoading: false, data: data);
      }
    });
  }
}

class _ListServiceCategory extends StatelessWidget {
  final bool isLoading;
  final List<ServiceCategoryModel> data;
  const _ListServiceCategory({
    required this.isLoading,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading ? _ListLoadingData(data: data) : _ListData(data: data);
  }
}

class _ListLoadingData extends StatelessWidget {
  final List<ServiceCategoryModel> data;
  const _ListLoadingData({required this.data});

  @override
  Widget build(BuildContext context) {
    return _StaggeredGridWrapper(
      data: data,
      children: [
        for (var i = 0; i < data.length; i++)
          _Item(e: data[i], isLoading: true, index: i)
      ],
    );
  }
}

class _ListData extends StatelessWidget {
  final List<ServiceCategoryModel> data;
  const _ListData({required this.data});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: _StaggeredGridWrapper(
        data: data,
        children: [
          for (var i = 0; i < data.length; i++)
            _Item(
              e: data[i],
              isLoading: false,
              index: i,
            )
        ],
      ),
    );
  }
}

class _Item extends GetView<CategoriesServiceController> {
  final bool isLoading;
  final int index;
  final ServiceCategoryModel e;
  const _Item({
    required this.isLoading,
    required this.e,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = AnimationConfiguration.staggeredList(
      position: index,
      child: StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: index.isEven ? 2 : 1.5,
        child: FadeInAnimation(
          curve: Curves.decelerate,
          child: SlideAnimation(
            duration: const Duration(milliseconds: 410),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: ExtendedImage.asset(
                    controller.getImage(e.type),
                  ).image,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  e.name,
                  style: kTheme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    Widget loadingChild = StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: index.isEven ? 1.5 : 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
        ),
        child: Center(
          child: BaseShimmer(
            child: Text(
              e.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
    return isLoading ? loadingChild : child;
  }
}

class _StaggeredGridWrapper extends StatelessWidget {
  const _StaggeredGridWrapper({
    required this.data,
    required this.children,
  });

  final List<ServiceCategoryModel> data;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        StaggeredGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: children,
        ),
      ],
    );
  }
}
