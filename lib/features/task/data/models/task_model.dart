// class Task {
//   String id;
//   String name;
//   String workType;
//   String status;
//   String description;
//   String assignedTo;
//   DateTime startDate;
//   DateTime endDate;
//   String? attachment;

//   Task({
//     required this.id,
//     required this.name,
//     required this.workType,
//     required this.status,
//     required this.description,
//     required this.assignedTo,
//     required this.startDate,
//     required this.endDate,
//     this.attachment,
//   });
// }



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