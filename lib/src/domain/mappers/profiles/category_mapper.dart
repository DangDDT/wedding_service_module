import 'package:wedding_service_module/core/constants/default_value_mapper_constants.dart';
import 'package:wedding_service_module/src/domain/mappers/z_mapper.dart';
import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wss_repository/entities/category.dart';

import '../base/base_data_mapper_profile.dart';

class CategoryMapper
    extends BaseDataMapperProfile<Category, ServiceCategoryModel> {
  @override
  ServiceCategoryModel mapData(Category entity, Mapper mapper) {
    return ServiceCategoryModel(
      id: entity.id.toString(),
      name: entity.name?.toString() ??
          DefaultValueMapperConstants.defaultStringValue,
      code: entity.id.toString(),
      description: entity.description?.toString() ??
          DefaultValueMapperConstants.defaultStringValue,
      commissionRate: entity.commission?.commisionValue ??
          DefaultValueMapperConstants.defaultDoubleValue,
    );
  }
}
