import 'dart:math';

import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/models/image_model.dart';
import 'package:wedding_service_module/src/domain/models/service_profit_statement_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';

import '../models/service_category_model.dart';

class Dummy {
  static final List<ServiceCategoryModel> dummyServiceCategories = [
    ServiceCategoryModel(
      id: 1,
      code: "VAY_CUOI",
      name: "Váy cưới",
      description: "Váy cưới",
    ),
    ServiceCategoryModel(
      id: 2,
      code: "AO_DAI",
      name: "Áo dài",
      description: "Áo dài",
    ),
    ServiceCategoryModel(
      id: 3,
      code: "VEST",
      name: "Vest",
      description: "Vest",
    ),
    ServiceCategoryModel(
      id: 4,
      code: "TRANG_DIEM",
      name: "Trang điểm",
      description: "Trang điểm",
    ),
    ServiceCategoryModel(
      id: 5,
      code: "DUA_RUOC",
      name: "Đưa rước",
      description: "Đưa rước",
    ),
    ServiceCategoryModel(
      id: 6,
      code: "NHA_HANG",
      name: "Nhà hàng",
      description: "Nhà hàng",
    ),
    ServiceCategoryModel(
      id: 7,
      code: "TRAP_CUOI",
      name: "Tráp cưới",
      description: "Tráp cưới",
    ),
    ServiceCategoryModel(
      id: 8,
      code: "CHUP_ANH",
      name: "Chụp ảnh",
      description: "Chụp ảnh",
    ),
    ServiceCategoryModel(
      id: 9,
      code: "MC",
      name: "MC",
      description: "MC",
    ),
  ];

  static final services = List.generate(
    20,
    (index) {
      final commissionRate = Random().nextDouble();
      final price =
          (Random().nextDouble() * 1000000).clamp(1000000.0, 20000000.0);
      final actualRevenue = price - (price * commissionRate);
      return WeddingServiceModel(
        id: '$index-1dasdsd',
        name: 'Xe Vinfast VF e34 - $index',
        description:
            'Xe Vinfast VF e34 với 4 chỗ ngồi, các bạn có thể chọn màu sắc theo ý thích',
        unit: 'Chiếc',
        price: price,
        actualRevenue: actualRevenue,
        commissionRate: commissionRate,
        rating: Random().nextDouble() * 5,
        coverImage:
            'https://www.churchofengland.org/sites/default/files/2021-12/Photography.jpg',
        images: [
          ImageModel(
            id: '1',
            imageUrl:
                'https://petapixel.com/assets/uploads/2020/03/wedding5.jpg',
          ),
          ImageModel(
            id: '3',
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Wedding_photographer_at_work.jpg/640px-Wedding_photographer_at_work.jpg',
          ),
        ],
        registeredAt: DateTime.now().subtract(const Duration(days: 1)),
        state: WeddingServiceState.values[Random().nextInt(3) + 1],
        profitStatement: index % 2 == 0
            ? null
            : const ProfitStatementModel(
                totalRevenue: 20 * 1200.0,
                totalOrder: 20,
                totalProductProvided: 250,
              ),
      );
    },
  );
}
