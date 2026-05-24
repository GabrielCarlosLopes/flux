import 'package:flux/features/tasks/domain/entities/task.dart';
import 'package:isar/isar.dart';

part 'task_model.g.dart'; // Será gerado pelo build_runner

@collection
class TaskModel {
  Id id = Isar.autoIncrement;

  late String title;

  @enumerated
  late TaskStatus status;

  @enumerated
  late HumanPriority priority;

  @enumerated
  late SuggestedEnergy energy;

  late List<String> microtaskTitles;
  late List<bool> microtaskStates;

  late DateTime createdAt;
  late DateTime updatedAt;
}
