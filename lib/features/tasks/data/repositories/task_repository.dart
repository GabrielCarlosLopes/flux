import 'package:flux/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Task> createTask(Task task);
  Future<List<Task>> getInboxTasks();
  Future<Task?> getActiveTask();
  Future<void> setActiveTask(int id);
  Future<void> completeTask(int id);
  Future<void> archiveTask(int id);
}
