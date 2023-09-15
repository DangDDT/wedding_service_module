// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'extend_info_model.dart';
import 'image_model.dart';

class ServiceModel {
  final dynamic id;
  final String name;
  final String description;
  final String imageCover;
  final List<ImageModel> albums;
  final String unit;
  final double price;
  final ExtendInfoModel extendInfomation;
  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageCover,
    required this.albums,
    required this.unit,
    required this.price,
    required this.extendInfomation,
  });
}
