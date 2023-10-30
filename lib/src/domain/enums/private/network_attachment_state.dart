enum NetworkAttachmentState {
  idle,
  downloading,
  downloaded,
  error;
}

extension LocalAttachmentStateX on NetworkAttachmentState {
  bool get isIdle => this == NetworkAttachmentState.idle;

  bool get isDownloading => this == NetworkAttachmentState.downloading;

  bool get isDownloaded => this == NetworkAttachmentState.downloaded;

  bool get isError => this == NetworkAttachmentState.error;

  String get title {
    switch (this) {
      case NetworkAttachmentState.idle:
        return 'Chưa tải xuống';
      case NetworkAttachmentState.downloading:
        return 'Đang tải xuống';
      case NetworkAttachmentState.downloaded:
        return 'Đã tải xuống';
      case NetworkAttachmentState.error:
        return 'Lỗi';
      default:
        return '';
    }
  }
}
