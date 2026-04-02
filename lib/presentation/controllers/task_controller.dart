import '../../features/task/data/models/task_model.dart';
import '../../features/task/data/models/task_store.dart';

class TaskController {

  /// ➕ Add Task
  void addTask(TaskModel task) {
    TaskStore.addTask(task);
  }

  /// ❌ Delete Task
  void deleteTask(String id) {
    TaskStore.tasks.removeWhere((task) => task.id == id);
  }

  /// ✏️ Update Task
  void updateTask(TaskModel updatedTask) {
    final index =
        TaskStore.tasks.indexWhere((t) => t.id == updatedTask.id);

    if (index != -1) {
      TaskStore.tasks[index] = updatedTask;
    }
  }

  /// 📥 Get All Tasks
  List<TaskModel> getTasks() {
    return TaskStore.tasks;
  }

  /// 🔍 Get Task By ID
  TaskModel? getTaskById(String id) {
    try {
      return TaskStore.tasks.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }
}