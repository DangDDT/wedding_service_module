import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/models/network_attachment_model.dart';

/// Mixin to handle network attachment downloader
///
/// Call [loadAttachment] to load attachment from [attachments]
/// before using [networkAttachments]
mixin NetworkDownloaderMixin {
  /// Network attachment downloader instance
  ///
  /// This instance will be used to manage and download network attachments
  final networkAttachmentDownloader = NetWorkDownloader();

  ///Shortcut to get networkAttachments
  List<NetworkAttachmentModel> get networkAttachments =>
      networkAttachmentDownloader.networkAttachments;
}

class NetWorkDownloader {
  // final _logger = VifLogger.forContext<GopYModule>();
  final networkAttachments = <NetworkAttachmentModel>[].obs;

  //TODO: Implement this
  // Future<void> loadAttachment(List<AttachmentModel> attachments) async {
  //   if (attachments.isEmpty) {
  //     return;
  //   }
  //   networkAttachments.clear();

  //   for (final attachment in attachments) {
  //     final localPath = await FileHelper.checkFileExits(attachment.name);
  //     networkAttachments.add(
  //       NetworkAttachmentModel(
  //         name: attachment.name,
  //         networkPath: attachment.path,
  //         state: (localPath != null)
  //             ? StateDataStatus.loaded
  //             : StateDataStatus.idle,
  //         size: attachment.size,
  //         localPath: localPath,
  //       ),
  //     );
  //   }
  // }

  /// Download file from [networkAttachments] at [index]
  Future<void> openOrDownloadFile(int index) async {
    if (index >= networkAttachments.length) {
      return;
    }
    try {
      //TODO: Implement this

      // final authData = ModuleManager.I.authConfigs.userData;

      // final attachment = networkAttachments[index];
      // if (attachment.state == StateDataStatus.loaded) {
      //   if (attachment.localPath == null) {
      //     return;
      //   }
      //   await VIFBase.I.fileHelper.open(
      //     attachment.localPath!,
      //   );
      //   return;
      // }
      // networkAttachments[index] = attachment.copyWith(
      //   state: StateDataStatus.loading,
      // );

      // final saveDir = await VIFBase.I.fileHelper.getDirectoryPath(
      //   GopYModule.packageName,
      //   userID: authData.userId.toString(),
      // );

      // final downloadedPath = await VIFBase.I.downloader.download(
      //   categorize: GopYModule.packageName,
      //   fileID: attachment.networkPath,
      //   fileName: attachment.name,
      //   saveDir: saveDir,
      // );

      if (networkAttachments.isEmpty) {
        return;
      }

      // if (downloadedPath != null) {
      //   networkAttachments[index] = attachment.copyWith(
      //     state: StateDataStatus.loaded,
      //     localPath: () => downloadedPath,
      //   );
      // } else {
      //   networkAttachments[index] = attachment.copyWith(
      //     state: StateDataStatus.error,
      //   );
      // }
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
