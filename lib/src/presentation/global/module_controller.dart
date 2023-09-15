import 'package:get/get.dart';

import '../../../core/utils/helpers/logger.dart';
import '../../domain/domain.dart';
import '../../domain/mock/dummy.dart';
import '../../domain/models/service_category_model.dart';
import '../view_models/state_model.dart';

class ModuleController extends GetxController {
  StateModel<List<ServiceCategoryModel>> serviceCategories =
      StateModel<List<ServiceCategoryModel>>(
    data: Rx<List<ServiceCategoryModel>>(
      ListServiceCategoryModel.empty,
    ),
  );

  Future<void> loadServiceCategories() async {
    serviceCategories.state.value = LoadingState.loading;
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        serviceCategories.data.value = Dummy.dummyServiceCategories;
        serviceCategories.state.value = LoadingState.success;
      });
    } catch (e) {
      Logger.log(
        e.toString(),
        name: 'ModuleController_loadServiceCategories',
      );
      serviceCategories.data.value = ListServiceCategoryModel.error;
      serviceCategories.state.value = LoadingState.error;
    }
  }
}
