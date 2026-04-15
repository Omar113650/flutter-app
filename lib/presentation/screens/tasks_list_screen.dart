import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create_task_screen.dart';
import 'task_details_screen.dart';

class TasksListScreen extends StatelessWidget {
  const TasksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050507),
      appBar: AppBar(
        title: const Text("All Tasks"),
        backgroundColor: const Color(0xFF3F3387),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("tasks")
            .orderBy("createdAt", descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!.docs;

          if (tasks.isEmpty) {
            return const Center(
              child: Text("No Tasks Yet", style: TextStyle(color: Colors.white, fontSize: 20)),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, i) {
              final task = tasks[i];
              final taskData = task.data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C2E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsScreen(task: taskData),
                      ),
                    );
                  },

                  title: Text(
                    taskData["name"] ?? "Untitled",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  subtitle: Text(
                    taskData["status"] ?? "Pending",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),

                    onSelected: (value) async {
                      if (value == "delete") {
                        await FirebaseFirestore.instance
                            .collection("tasks")
                            .doc(task.id)
                            .delete();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Task Deleted")),
                        );
                      }

                      if (value == "edit") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateTaskScreen(
                              taskToEdit: taskData,
                            ),
                          ),
                        );
                      }
                    },

                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: "edit",
                        child: Text("Edit Task"),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}