import 'package:wedding_service_module/core/constants/default_value_mapper_constants.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/mappers/z_mapper.dart';
import 'package:wedding_service_module/src/domain/models/image_model.dart';
import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wedding_service_module/src/domain/models/service_profit_statement_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wss_repository/entities/service.dart';

import '../base/base_data_mapper_profile.dart';

class WeddingServiceMapper
    extends BaseDataMapperProfile<Service, WeddingServiceModel> {
  @override
  WeddingServiceModel mapData(Service entity, Mapper mapper) {
    return WeddingServiceModel(
      id: entity.id.toString(),
      name: entity.name?.toString() ??
          DefaultValueMapperConstants.defaultStringValue,
      rating: entity.rating?.toDouble() ??
          DefaultValueMapperConstants.defaultDoubleValue,
      category: (entity.category != null)
          ? mapper.mapData<Category, ServiceCategoryModel>(entity.category!)
          : ServiceCategoryModel.empty(),
      price: entity.currentPrices?.price ??
          DefaultValueMapperConstants.defaultDoubleValue,
      state: WeddingServiceStateX.fromStringCode(entity.status),
      description: entity.description?.toString() ??
          DefaultValueMapperConstants.defaultStringValue,
      coverImage: entity.serviceImages?.firstOrNull?.imageUrl ??
          DefaultValueMapperConstants.defaultStringValue,
      images: entity.serviceImages
              ?.toList()
              .map((e) => ImageModel(
                    id: e.imageUrl.toString(),
                    imageUrl: e.imageUrl.toString(),
                  ))
              .toList() ??
          [],

      /// Cung cấp thêm data của ngày tạo của service (nếu có ngày duyệt càng tốt)
      registeredAt: DefaultValueMapperConstants.defaultDateTimeValue,

      ///Cung cấp thêm thông tin về thống kê của service
      profitStatement: const ProfitStatementModel(
        /// Cung cấp thêm thông tin về tổng số sản phẩm đã cung cấp
        /// - Số lượng quantity của các đơn hàng (ở đây chắc bằng với số order luôn á tại quantity = 1)
        totalProductProvided: DefaultValueMapperConstants.defaultIntValue,

        /// - Cung cấp thêm tổng doanh thu mà service đã thu về qua các đơn hàng
        /// - Giá này là giá mà chưa trừ đi phần hoa hồng cho cửa hàng
        totalRevenue: DefaultValueMapperConstants.defaultDoubleValue,

        /// - Cung cấp thêm tổng số đơn hàng đã được đặt
        totalOrder: DefaultValueMapperConstants.defaultIntValue,
      ),

      /// Cung cấp thêm thông tin về doanh thu của service
      /// - Giá này là giá đã trừ đi phần hoa hồng cho cửa hàng
      actualRevenue: DefaultValueMapperConstants.defaultDoubleValue,

      /// Cung cấp thêm đơn vị tính của service
      unit: DefaultValueMapperConstants.defaultStringValue,

      /// Cung cấp thêm thông tin về tỉ lệ hoa hồng của service (bằng với category luôn á)
      commissionRate: DefaultValueMapperConstants.defaultDoubleValue,
    );
  }
}
