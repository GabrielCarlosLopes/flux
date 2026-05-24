enum TaskStatus { inbox, active, completed, archived }

enum HumanPriority { easyToStart, fast, needsEnergy, urgent }

enum SuggestedEnergy { low, medium, high }

class Microtask {
  final String title;
  final bool isCompleted;

  Microtask({required this.title, this.isCompleted = false});
}

class Task {
  final int? id;
  final String title;
  final TaskStatus status;
  final List<Microtask> microtasks;
  final HumanPriority priority;
  final SuggestedEnergy energy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    this.id,
    required this.title,
    this.status = TaskStatus.inbox,
    this.microtasks = const [],
    required this.priority,
    required this.energy,
    required this.createdAt,
    required this.updatedAt,
  });
}
