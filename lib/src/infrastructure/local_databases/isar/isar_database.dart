import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/helpers/logger.dart';

class IsarDatabase {
  IsarDatabase._();

  static final IsarDatabase instance = IsarDatabase._();

  static final List<CollectionSchema<dynamic>> _schemaCollections = [];

  late final Isar database;

  ///Init Isar database
  ///
  ///throw [InitialDatabaseException] if failed
  static Future<void> init() async {
    try {
      Directory applicationDir;
      //Get application directory
      if (Platform.isAndroid) {
        applicationDir = await getApplicationDocumentsDirectory();
      } else {
        applicationDir = await getApplicationSupportDirectory();
      }

      final openPath =
          '${applicationDir.path}/isar_databases/${WeddingServiceModule.packageName}/';
      final openDir = Directory(openPath);
      if (!openDir.existsSync()) {
        openDir.createSync(recursive: true);
      }
      if (_schemaCollections.isEmpty) return;
      //Init hive database in application dir
      instance.database = Isar.openSync(
        _schemaCollections,
        name: '${WeddingServiceModule.packageName}_Isar',
        directory: openPath,
      );
    } catch (exception, stackTrace) {
      Logger.log(
        exception.toString(),
        name: 'IsarDatabase_init',
        stackTrace: stackTrace,
      );
    }
  }
}
