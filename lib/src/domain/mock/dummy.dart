import '../enums/private/service_category_enum.dart';
import '../models/service_category_model.dart';

class Dummy {
  static final List<ServiceCategoryModel> dummyServiceCategories = [
    ServiceCategoryModel(
      id: 1,
      code: "VAY_CUOI",
      name: "Váy cưới",
      description: "Váy cưới",
      type: ServiceCategoryEnum.vayCuoi,
    ),
    ServiceCategoryModel(
      id: 2,
      code: "AO_DAI",
      name: "Áo dài",
      description: "Áo dài",
      type: ServiceCategoryEnum.aoDai,
    ),
    ServiceCategoryModel(
      id: 3,
      code: "VEST",
      name: "Vest",
      description: "Vest",
      type: ServiceCategoryEnum.vest,
    ),
    ServiceCategoryModel(
      id: 4,
      code: "TRANG_DIEM",
      name: "Trang điểm",
      description: "Trang điểm",
      type: ServiceCategoryEnum.trangDiem,
    ),
    ServiceCategoryModel(
      id: 5,
      code: "DUA_RUOC",
      name: "Đưa rước",
      description: "Đưa rước",
      type: ServiceCategoryEnum.duaRuoc,
    ),
    ServiceCategoryModel(
      id: 6,
      code: "NHA_HANG",
      name: "Nhà hàng",
      description: "Nhà hàng",
      type: ServiceCategoryEnum.nhaHang,
    ),
    ServiceCategoryModel(
      id: 7,
      code: "TRAP_CUOI",
      name: "Tráp cưới",
      description: "Tráp cưới",
      type: ServiceCategoryEnum.trapCuoi,
    ),
    ServiceCategoryModel(
      id: 8,
      code: "CHUP_ANH",
      name: "Chụp ảnh",
      description: "Chụp ảnh",
      type: ServiceCategoryEnum.trapCuoi,
    ),
    ServiceCategoryModel(
      id: 9,
      code: "MC",
      name: "MC",
      description: "MC",
      type: ServiceCategoryEnum.mc,
    ),
  ];
}
