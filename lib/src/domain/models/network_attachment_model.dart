// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wedding_service_module/src/domain/enums/private/network_attachment_state.dart';

class NetworkAttachmentModel {
  NetworkAttachmentModel({
    required this.name,
    required this.networkPath,
    required this.state,
    this.size,
    this.localPath,
  });

  final String name;
  final String networkPath;
  final NetworkAttachmentState state;
  final int? size;
  final String? localPath;

  @override
  bool operator ==(covariant NetworkAttachmentModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.networkPath == networkPath &&
        other.state == state &&
        other.size == size &&
        other.localPath == localPath;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        networkPath.hashCode ^
        state.hashCode ^
        size.hashCode ^
        localPath.hashCode;
  }

  NetworkAttachmentModel copyWith({
    String? name,
    String? networkPath,
    NetworkAttachmentState? state,
    ValueGetter<int?>? size,
    ValueGetter<String?>? localPath,
  }) {
    return NetworkAttachmentModel(
      name: name ?? this.name,
      networkPath: networkPath ?? this.networkPath,
      state: state ?? this.state,
      size: size != null ? size.call() : this.size,
      localPath: localPath != null ? localPath.call() : this.localPath,
    );
  }
}
