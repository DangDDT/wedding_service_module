import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_wedding_service_param.dart';

abstract class IWeddingServiceService {
  Future<ServiceCategoryModel> getCategory(String id);
  Future<List<WeddingServiceModel>> getServices(GetWeddingServiceParam param);
}
