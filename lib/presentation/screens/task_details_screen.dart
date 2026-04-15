import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskDetailsScreen({super.key, required this.task});

  String safe(String key) {
    return task[key]?.toString() ?? "Not provided";
  }

  String formatDate(String? isoString) {
    if (isoString == null || isoString == "Not provided") return "Not provided";
    try {
      final date = DateTime.parse(isoString);
      return DateFormat('dd MMMM yyyy').format(date); // 10 April 2026
    } catch (e) {
      return isoString;
    }
  }

  Future<void> _openFile(BuildContext context, String? fileUrl) async {
    if (fileUrl == null || fileUrl.isEmpty || fileUrl == "Not provided") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file attached")),
      );
      return;
    }

    try {
      final Uri uri = Uri.parse(fileUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cannot open this file")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error opening file: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String fileName = safe("fileName");
    final String? fileUrl = task['fileUrl']?.toString(); // ← مهم: رابط الملف

    return Scaffold(
      backgroundColor: const Color(0xFF050507),
      appBar: AppBar(
        title: Text(safe("name")),
        backgroundColor: const Color(0xFF3F3387),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard(
              title: "Task Information",
              children: [
                _detailRow("Task Name", safe("name")),
                _detailRow("Work Type", safe("workType")),
                _detailRow("Status", safe("status")),
                _detailRow("Assigned To", safe("assignedTo")),
              ],
            ),

            const SizedBox(height: 16),

            _infoCard(
              title: "Description",
              children: [
                Text(
                  safe("description"),
                  style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _infoCard(
              title: "Dates",
              children: [
                _detailRow("Start Date", formatDate(safe("startDate"))),
                _detailRow("End Date", formatDate(safe("endDate"))),
              ],
            ),

            const SizedBox(height: 16),

            _infoCard(
              title: "Attachment",
              children: [
                InkWell(
                  onTap: () => _openFile(context, fileUrl),
                  child: _detailRow(
                    "File Name",
                    fileName,
                    isClickable: fileUrl != null && fileUrl.isNotEmpty,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF766BAF),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.white24, height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool isClickable = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isClickable ? Colors.blue : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: isClickable ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}































































