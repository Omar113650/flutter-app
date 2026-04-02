import 'package:flutter/material.dart';
import '../task_model.dart';
import '../task_model.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsScreen({super.key, required this.task});

  String formatDate(DateTime? date) {
    if (date == null) return "-";
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050507),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F3387),
        title: Text(task.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(title: "Status", value: task.status, icon: Icons.flag),

            _card(title: "Work Type", value: task.workType, icon: Icons.work),

            _card(
              title: "Assigned To",
              value: task.assignedTo,
              icon: Icons.person,
            ),

            _card(
              title: "Description",
              value: task.description.isEmpty ? "-" : task.description,
              icon: Icons.description,
            ),

            // _card(
            //   title: "Attachment",
            //   value: task.fileName!,
            //   icon: Icons.attach_file,
            // ),

            _card(
              title: "Attachment",
              value: task.fileName ?? "No file attached",
              icon: Icons.attach_file,
            ),

            _card(
              title: "End Date",
              value: formatDate(task.endDate),
              icon: Icons.event,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2249),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB3B5E1)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
