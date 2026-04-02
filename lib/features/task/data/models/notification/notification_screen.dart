import 'package:flutter/material.dart';
import '../task_store.dart';
import '../task_model.dart';
import './Task.Details Screen.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final tasks = TaskStore.tasks;

    return Scaffold(
      backgroundColor: const Color(0xFF050507),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F3387),
        title: const Text("Tasks"),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                "No Tasks Yet 🚀",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskDetailsScreen(task: task),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0xFF2D2249),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(
                        task.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        task.status,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white),
                    ),
                  ),
                );
              },
            ),
    );
  }
}