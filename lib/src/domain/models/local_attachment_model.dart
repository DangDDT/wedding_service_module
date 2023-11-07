// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:wedding_service_module/src/domain/enums/private/local_attachment_state.dart';

class LocalAttachmentModel<T> {
  const LocalAttachmentModel({
    required this.localPath,
    required this.name,
    required this.size,
    required this.file,
    this.state = LocalAttachmentState.idle,
    this.attachmentNetworkData,
    this.networkPath,
  });

  final String name;
  final String localPath;
  final int? size;
  final File? file;
  final LocalAttachmentState state;
  final String? networkPath;
  final T? attachmentNetworkData;

  String get fileExtension => path.extension(path.basename(localPath));

  @override
  bool operator ==(covariant LocalAttachmentModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.localPath == localPath &&
        other.size == size &&
        other.file == file &&
        other.state == state &&
        other.networkPath == networkPath &&
        other.attachmentNetworkData == attachmentNetworkData;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        localPath.hashCode ^
        size.hashCode ^
        file.hashCode ^
        state.hashCode ^
        networkPath.hashCode ^
        attachmentNetworkData.hashCode;
  }

  LocalAttachmentModel copyWith({
    String? name,
    String? localPath,
    ValueGetter<int?>? size,
    ValueGetter<File?>? file,
    LocalAttachmentState? state,
    ValueGetter<String?>? networkPath,
    ValueGetter<T?>? attachmentNetworkData,
  }) {
    return LocalAttachmentModel(
      name: name ?? this.name,
      localPath: localPath ?? this.localPath,
      size: size != null ? size.call() : this.size,
      file: file != null ? file.call() : this.file,
      state: state ?? this.state,
      networkPath: networkPath != null ? networkPath.call() : this.networkPath,
      attachmentNetworkData: attachmentNetworkData != null
          ? attachmentNetworkData.call()
          : this.attachmentNetworkData,
    );
  }
}
