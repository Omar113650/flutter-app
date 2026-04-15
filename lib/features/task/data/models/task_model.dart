class TaskModel {
  final String id;
  final String name;
  final String workType;
  final String status;
  final String description;
  final String assignedTo;
  final String? fileName;
  final DateTime? startDate;
  final DateTime? endDate;

  TaskModel({
    required this.id,
    required this.name,
    required this.workType,
    required this.status,
    required this.description,
    required this.assignedTo,
    this.fileName,
    this.startDate,
    this.endDate,
  });
}