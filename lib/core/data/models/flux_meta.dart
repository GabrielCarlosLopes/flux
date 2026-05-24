import 'package:isar/isar.dart';

part 'flux_meta.g.dart';

/// Placeholder collection for schema validation and future migrations.
@collection
class FluxMeta {
  Id id = Isar.autoIncrement;

  late int schemaVersion;

  late DateTime createdAt;
}
