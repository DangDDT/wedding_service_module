import 'package:get/get.dart';
import 'package:wedding_service_module/src/domain/mappers/z_mapper.dart';
import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_wedding_service_param.dart';
import 'package:wedding_service_module/src/domain/services/i_wedding_service_service.dart';
import 'package:wss_repository/entities/category.dart';
import 'package:wss_repository/wss_repository.dart';

class WeddingServiceService extends IWeddingServiceService {
  final ICategoryRepository _categoryRepository =
      Get.find<ICategoryRepository>();
  final Mapper mapper = Mapper.instance;
  @override
  Future<ServiceCategoryModel> getCategory(String id) async {
    final result = await _categoryRepository.getCategory(id: id);
    return mapper.mapData<Category, ServiceCategoryModel>(result);
  }

  @override
  Future<List<WeddingServiceModel>> getServices(GetWeddingServiceParam param) {
    // TODO: implement getServices
    throw UnimplementedError();
  }
}
