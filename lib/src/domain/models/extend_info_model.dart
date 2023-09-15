import '../enums/private/service_category_enum.dart';

abstract class ExtendInfoModel {
  final ServiceCategoryEnum category;
  ExtendInfoModel({
    required this.category,
  });
}

class DressExtendInfoModel extends ExtendInfoModel {
  DressExtendInfoModel() : super(category: ServiceCategoryEnum.vayCuoi);
}

class AoDaiExtendInfoModel extends ExtendInfoModel {
  AoDaiExtendInfoModel() : super(category: ServiceCategoryEnum.aoDai);
}

class VestExtendInfoModel extends ExtendInfoModel {
  VestExtendInfoModel() : super(category: ServiceCategoryEnum.vest);
}

class TrangDiemExtendInfoModel extends ExtendInfoModel {
  TrangDiemExtendInfoModel() : super(category: ServiceCategoryEnum.trangDiem);
}

class DuaRuocExtendInfoModel extends ExtendInfoModel {
  DuaRuocExtendInfoModel() : super(category: ServiceCategoryEnum.duaRuoc);
}

class NhaHangExtendInfoModel extends ExtendInfoModel {
  NhaHangExtendInfoModel() : super(category: ServiceCategoryEnum.nhaHang);
}

class TrapCuoiExtendInfoModel extends ExtendInfoModel {
  TrapCuoiExtendInfoModel() : super(category: ServiceCategoryEnum.trapCuoi);
}

class ChupAnhExtendInfoModel extends ExtendInfoModel {
  ChupAnhExtendInfoModel() : super(category: ServiceCategoryEnum.chupAnh);
}

class MCExtendInfoModel extends ExtendInfoModel {
  MCExtendInfoModel() : super(category: ServiceCategoryEnum.mc);
}
