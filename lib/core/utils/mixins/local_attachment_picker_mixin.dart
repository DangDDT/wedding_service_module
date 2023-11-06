import 'package:core_picker/core/core_picker.dart';
import 'package:core_picker/core/module_configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/enums/private/local_attachment_state.dart';
import 'package:wedding_service_module/src/domain/models/local_attachment_model.dart';

mixin LocalAttachmentPickerMixin on GetxController {
  final attachmentPicker = _AttachmentPicker();

  List<LocalAttachmentModel> get attachments => attachmentPicker.attachments;
}

class _AttachmentPicker {
  ///This key can be add to [FormField.key] to make it work with [FormField]
  final formFieldKey = GlobalKey<FormFieldState<List<LocalAttachmentModel>>>();
  int _maxAttachment = 5;

  final attachments = RxList<LocalAttachmentModel>();

  bool get isAllUploaded => attachments.every((e) => e.state.isUploaded);

  ///Set max attachment can be picked
  void setMaxAttachment(int maxAttachment) {
    _maxAttachment = maxAttachment;
  }

  Future<void> pickAttachment() async {
    final context = Get.context;
    if (context == null) {
      await Get.dialog(AlertDialog(
        title: const Text('Lỗi'),
        content: const Text(
          'Hiện tại không thể chọn file, vui lòng thử lại sau.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Đóng'),
          ),
        ],
      ));
      return;
    }

    final int remainAttachment = _maxAttachment - attachments.length;

    if (remainAttachment <= 0) {
      await Get.dialog(AlertDialog(
        title: const Text('Lỗi'),
        content: const Text(
          'Bạn đã chọn đủ số lượng file cho phép.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Đóng'),
          ),
        ],
      ));
      return;
    }

    final result = await CorePicker.showPickerMenu(
      isShowLog: true,
      submitButtonTitle: 'Chọn',
      mediaPickerOption: MediaPickerOption(
        isMultiSelection: true,
        //TODO: handle max file
      ),
      attachmentTypes: [AttachmentType.media],
      submitButtonIcon: Icons.check,
    );

    if (result == null) return;

    if (result.data.isEmpty) return;

    try {
      final medias = result.getImageAttachmentData();

      for (final item in medias) {
        final file = item.file;
        if (file == null) continue;
        final attachment = LocalAttachmentModel(
          file: file,
          size: file.lengthSync(),
          name: path.basename(file.path),
          localPath: file.path,
          state: LocalAttachmentState.idle,
        );
        attachments.add(attachment);
        formFieldKey.currentState?.didChange(attachments);
      }
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> removeAttachment(LocalAttachmentModel attachment) async {
    try {
      attachments.remove(attachment);
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> uploadAll() async {
    try {
      // final uploadTasks = <Future<VIFFileUploaderResult?>>[];

      for (int i = 0; i < attachments.length; i++) {
        if (attachments[i].state.isUploading ||
            attachments[i].state.isUploaded) {
          continue;
        }

        //TODO: handle upload file

        // final uploadTask = VIFBase.I.uploader
        //     .uploadFromPath(
        //   pathFile: attachments[i].localPath,
        //   categorize: GopYModule.packageName,
        // )
        //     .then((value) {
        //   if (value != null) {
        //     attachments[i] = attachments[i].copyWith(
        //       state: LocalAttachmentState.uploaded,
        //       networkPath: () => value.data,
        //     );
        //   } else {
        //     attachments[i] = attachments[i].copyWith(
        //       state: LocalAttachmentState.error,
        //     );
        //     throw Exception('Upload file thất bại -> ${attachments[i].name}');
        //   }
        // });
        // uploadTasks.add(uploadTask);
        // attachments[i] = attachments[i].copyWith(
        //   state: LocalAttachmentState.uploading,
        // );
      }
      // await Future.wait(uploadTasks);
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
