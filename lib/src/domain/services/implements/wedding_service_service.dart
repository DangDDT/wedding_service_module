import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/extensions/objec_ext.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/mappers/z_mapper.dart';
import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_wedding_service_param.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';
import 'package:wss_repository/entities/category.dart' show Category;
import 'package:wss_repository/entities/service.dart' show Service;
import 'package:wss_repository/requests/put_status_service_body.dart';
import 'package:wss_repository/wss_repository.dart';

class WeddingServiceService extends IWeddingServiceService {
  final _categoryRepository = Get.find<ICategoryRepository>();
  final _serviceRepository = Get.find<IServiceRepository>();
  final Mapper mapper = Mapper.instance;
  @override
  Future<ServiceCategoryModel> getCategory(String id) async {
    final result = await _categoryRepository.getCategory(id: id);
    return mapper.mapData<Category, ServiceCategoryModel>(result);
  }

  @override
  Future<List<WeddingServiceModel>> getServices(
    GetWeddingServiceParam param,
  ) async {
    final result = await _serviceRepository.getServices(
      param: GetServiceParam(
        status: param.status != null ? [param.status!.toStringCode()] : null,
        //TODO: check to change from date to date
        categoryId: param.categoryId,
        checkDate: null,
        priceFrom: param.priceFrom,
        priceTo: param.priceTo,
        page: param.pageIndex,
        pageSize: param.pageSize,
        sortKey: param.orderBy,
        sortOrder: param.orderType,
        createdAtFrom: param.fromDate,
        createdAtTo: param.toDate,
        name: param.name,
      ),
    );

    if (result.data.isNullOrEmpty) {
      return [];
    }

    return mapper.mapListData<Service, WeddingServiceModel>(result.data!);
  }

  @override
  Future<WeddingServiceModel> registerService(
    WeddingServiceModel service,
  ) async {
    final addedService = await _serviceRepository.postService(
      body: PostServiceBody(
        name: service.name,
        quantity: 1,
        imageUrls: service.images.map((e) => e.imageUrl).toList(),
        categoryid: service.category.id,
        unit: service.unit,
        price: service.price.toInt(),
        description: service.description,
      ),
    );

    return mapper.mapData<Service, WeddingServiceModel>(addedService);
  }

  @override
  Future<WeddingServiceModel> getDetail(String id) async {
    final data = await _serviceRepository.getService(id: id);
    return mapper.mapData<Service, WeddingServiceModel>(data);
  }

  @override
  Future<bool> reActiveService(String id) async {
    final result = await _serviceRepository.putStatusService(
      id: id,
      body: PutStatusServiceBody(
        status: WeddingServiceState.active.toStringCode(),
      ),
    );
    return result;
  }

  @override
  Future<bool> suspendService(String id) async {
    //TODO: check to change status
    final result = await _serviceRepository.putServiceStatus(
      id: id,
      body: PutServiceStatusBody(
        // : WeddingServiceState.active.toStringCode(),
        reason: null,
      ),
    );

    return result;
  }

  @override
  Future<bool> updateService(WeddingServiceModel service) async {
    final imageUrls = service.images.map((e) => e.imageUrl).toList();
    final result = await _serviceRepository.putService(
      id: service.id,
      body: PostServiceBody(
        name: service.name,
        quantity: null,
        imageUrls: imageUrls,
        categoryid: service.category.id,
        unit: service.unit,
        price: service.price.toInt(),
        description: service.description,
      ),
    );

    return result;
  }
}
