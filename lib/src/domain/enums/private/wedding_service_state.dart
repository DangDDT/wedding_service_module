import 'package:flutter/material.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

enum WeddingServiceState {
  /// The service is active
  active,

  /// The service is requesting
  registering,

  /// The service is rejected
  rejected,

  /// The service is suspended
  suspended;
}

extension WeddingServiceStateX on WeddingServiceState {
  String get title {
    switch (this) {
      case WeddingServiceState.active:
        return 'Đang kinh doanh';
      case WeddingServiceState.registering:
        return 'Chờ duyệt';
      case WeddingServiceState.rejected:
        return 'Bị từ chối';
      case WeddingServiceState.suspended:
        return 'Ngừng kinh doanh';
      default:
        return '';
    }
  }

  Color get color {
    switch (this) {
      case WeddingServiceState.active:
        return kTheme.colorScheme.primary;
      case WeddingServiceState.registering:
        return Colors.orange;
      case WeddingServiceState.rejected:
        return Colors.red;
      case WeddingServiceState.suspended:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  /// Weather the state is registering
  bool get isRegistering => this == WeddingServiceState.registering;

  /// Weather the state is active
  bool get isActive => this == WeddingServiceState.active;

  /// Weather the state is rejected
  bool get isRejected => this == WeddingServiceState.rejected;

  /// Weather the state is suspended
  bool get isSuspended => this == WeddingServiceState.suspended;
}
