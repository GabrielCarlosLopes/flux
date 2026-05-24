import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:flux/core/constants/app_constants.dart';
import 'package:flux/core/data/models/flux_meta.dart';
import 'package:flux/features/onboarding/data/models/onboarding_profile_model.dart';
import 'package:flux/core/services/database_service.dart';

void main() {
  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('flux_db_test_');
    await DatabaseService.close();
  });

  tearDown(() async {
    await DatabaseService.deleteFromDisk();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('instance throws StateError before init', () {
    expect(() => DatabaseService.instance, throwsA(isA<StateError>()));
  });

  test('init opens Isar with FluxMeta schema registered', () async {
    await DatabaseService.init(directory: tempDir.path);
    final isar = DatabaseService.instance;
    expect(isar.isOpen, isTrue);
    expect(isar.fluxMetas, isNotNull);
    expect(isar.onboardingProfileModels, isNotNull);
  });

  test('init is idempotent when already open', () async {
    await DatabaseService.init(directory: tempDir.path);
    await DatabaseService.init(directory: tempDir.path);
    expect(DatabaseService.instance.isOpen, isTrue);
  });

  test('close allows re-init in sequential test', () async {
    await DatabaseService.init(directory: tempDir.path);
    await DatabaseService.close();
    await DatabaseService.init(directory: tempDir.path);
    expect(DatabaseService.instance.isOpen, isTrue);
  });

  test('put and get FluxMeta', () async {
    await DatabaseService.init(directory: tempDir.path);
    final isar = DatabaseService.instance;
    final now = DateTime(2026, 5, 24, 12);

    await isar.writeTxn(() async {
      await isar.fluxMetas.put(
        FluxMeta()
          ..schemaVersion = AppConstants.schemaVersion
          ..createdAt = now,
      );
    });

    final stored = await isar.fluxMetas.where().findAll();
    expect(stored, hasLength(1));
    expect(stored.first.schemaVersion, AppConstants.schemaVersion);
    expect(stored.first.createdAt, now);
  });
}
