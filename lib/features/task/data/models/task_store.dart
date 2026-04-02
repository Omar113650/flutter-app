import 'task_model.dart';

class TaskStore {
  static List<TaskModel> tasks = [];

  static void addTask(TaskModel task) {
    tasks.add(task);
  }

  static void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
  }

  static void updateTask(TaskModel updated) {
    final index = tasks.indexWhere((t) => t.id == updated.id);
    if (index != -1) {
      tasks[index] = updated;
    }
  }

  static List<TaskModel> getAll() => tasks;
}