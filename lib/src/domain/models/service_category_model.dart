import '../enums/private/service_category_enum.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceCategoryModel {
  final dynamic id;
  final String code;
  final String name;
  final String description;
  final ServiceCategoryEnum type;

  ServiceCategoryModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.type,
  });

  factory ServiceCategoryModel.empty() {
    return ServiceCategoryModel(
      id: 0,
      code: "",
      name: "Đang tải",
      description: "",
      type: ServiceCategoryEnum.empty,
    );
  }

  factory ServiceCategoryModel.error() {
    return ServiceCategoryModel(
      id: 0,
      code: "",
      name: "Unknown",
      description: "",
      type: ServiceCategoryEnum.empty,
    );
  }

  factory ServiceCategoryModel.all() {
    return ServiceCategoryModel(
      id: -1,
      code: "",
      name: "Tất cả",
      description: "",
      type: ServiceCategoryEnum.all,
    );
  }

  factory ServiceCategoryModel.more() {
    return ServiceCategoryModel(
      id: 99999,
      code: "",
      name: "Xem thêm >",
      description: "",
      type: ServiceCategoryEnum.more,
    );
  }

  @override
  bool operator ==(covariant ServiceCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.name == name &&
        other.description == description &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        name.hashCode ^
        description.hashCode ^
        type.hashCode;
  }
}

class ListServiceCategoryModel {
  static List<ServiceCategoryModel> get empty {
    return [
      ServiceCategoryModel.empty(),
      ServiceCategoryModel.empty(),
      ServiceCategoryModel.empty(),
      ServiceCategoryModel.empty(),
      ServiceCategoryModel.empty(),
      ServiceCategoryModel.empty(),
    ];
  }

  static List<ServiceCategoryModel> get error {
    return [
      ServiceCategoryModel.error(),
      ServiceCategoryModel.error(),
      ServiceCategoryModel.error(),
      ServiceCategoryModel.error(),
      ServiceCategoryModel.error(),
      ServiceCategoryModel.error(),
    ];
  }
}
