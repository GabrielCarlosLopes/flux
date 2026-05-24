import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';
import '../../features/onboarding/data/models/onboarding_profile_model.dart';
import '../data/models/flux_meta.dart';

/// Singleton Isar access — open once at startup, never from UI directly.
abstract final class DatabaseService {
  static Isar? _isar;
  static String? _directory;

  /// Opens Isar in the application documents directory (or [directory] for tests).
  static Future<void> init({String? directory}) async {
    if (_isar != null && _isar!.isOpen) {
      return;
    }

    final dir = directory ?? await _defaultDirectory();
    _directory = dir;

    _isar = await Isar.open(
      [FluxMetaSchema, OnboardingProfileModelSchema],
      directory: dir,
      name: AppConstants.isarName,
    );
  }

  static Future<String> _defaultDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  /// Active Isar instance. Throws [StateError] if [init] was not called.
  static Isar get instance {
    final isar = _isar;
    if (isar == null || !isar.isOpen) {
      throw StateError(
        'DatabaseService not initialized. Call DatabaseService.init() first.',
      );
    }
    return isar;
  }

  /// Closes Isar and clears the singleton (for tests and teardown).
  static Future<void> close() async {
    final isar = _isar;
    _isar = null;
    if (isar != null && isar.isOpen) {
      await isar.close(deleteFromDisk: false);
    }
    _directory = null;
  }

  /// Directory used for the current/open database (tests).
  static String? get directory => _directory;

  /// Removes database files from disk (tests only).
  static Future<void> deleteFromDisk() async {
    final dir = _directory;
    await close();
    if (dir != null) {
      final dbDir = Directory(dir);
      if (await dbDir.exists()) {
        await for (final entity in dbDir.list()) {
          if (entity is File && entity.path.contains(AppConstants.isarName)) {
            await entity.delete();
          }
        }
      }
    }
  }
}
