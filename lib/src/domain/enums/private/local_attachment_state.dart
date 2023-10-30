enum LocalAttachmentState {
  idle,
  uploading,
  uploaded,
  error,
}

extension LocalAttachmentStateX on LocalAttachmentState {
  bool get isIdle => this == LocalAttachmentState.idle;

  bool get isUploading => this == LocalAttachmentState.uploading;

  bool get isUploaded => this == LocalAttachmentState.uploaded;

  bool get isError => this == LocalAttachmentState.error;

  String get title {
    switch (this) {
      case LocalAttachmentState.idle:
        return 'Chưa tải lên';
      case LocalAttachmentState.uploading:
        return 'Đang tải lên';
      case LocalAttachmentState.uploaded:
        return 'Đã tải lên';
      case LocalAttachmentState.error:
        return 'Lỗi';
      default:
        return '';
    }
  }
}
