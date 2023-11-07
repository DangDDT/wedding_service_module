// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wedding_service_module/src/domain/enums/private/network_attachment_state.dart';

class NetworkAttachmentModel<T> {
  NetworkAttachmentModel({
    required this.name,
    required this.attachmentNetworkData,
    required this.networkPath,
    required this.state,
    this.size,
    this.localPath,
  });

  final T attachmentNetworkData;
  final String name;
  final String networkPath;
  final NetworkAttachmentState state;
  final int? size;
  final String? localPath;

  @override
  bool operator ==(covariant NetworkAttachmentModel other) {
    if (identical(this, other)) return true;

    return other.attachmentNetworkData == attachmentNetworkData &&
        other.name == name &&
        other.networkPath == networkPath &&
        other.state == state &&
        other.size == size &&
        other.localPath == localPath;
  }

  @override
  int get hashCode {
    return attachmentNetworkData.hashCode ^
        name.hashCode ^
        networkPath.hashCode ^
        state.hashCode ^
        size.hashCode ^
        localPath.hashCode;
  }

  NetworkAttachmentModel copyWith({
    T? attachmentNetworkData,
    String? name,
    String? networkPath,
    NetworkAttachmentState? state,
    ValueGetter<int?>? size,
    ValueGetter<String?>? localPath,
  }) {
    return NetworkAttachmentModel(
      attachmentNetworkData:
          attachmentNetworkData ?? this.attachmentNetworkData,
      name: name ?? this.name,
      networkPath: networkPath ?? this.networkPath,
      state: state ?? this.state,
      size: size != null ? size.call() : this.size,
      localPath: localPath != null ? localPath.call() : this.localPath,
    );
  }
}
