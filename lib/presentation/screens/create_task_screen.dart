


// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:uuid/uuid.dart';
// import 'dart:typed_data';

// import '../../features/task/data/models/task_model.dart';
// import '../../features/task/data/models/task_store.dart';
// import '../../features/task/data/models/notification/notification_service.dart';

// class CreateTaskScreen extends StatefulWidget {
//   const CreateTaskScreen({super.key});

//   @override
//   State<CreateTaskScreen> createState() => _CreateTaskScreenState();
// }

// class _CreateTaskScreenState extends State<CreateTaskScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();

//   String name = '';
//   String workType = '';
//   String status = 'To Do';
//   String description = '';
//   String assignedTo = '';

//   DateTime? startDate;
//   DateTime? endDate;

//   // ✅ FIX: Web + Mobile safe
//   String? fileName;
//   Uint8List? fileBytes;

//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   final primary = const Color(0xFF3F3387);
//   final secondary = const Color(0xFF766BAF);
//   final soft = const Color(0xFFB3B5E1);
//   final surface = const Color(0xFFFBFBFB);
//   final dark = const Color(0xFF050507);

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );

//     _fadeAnimation =
//         CurvedAnimation(parent: _controller, curve: Curves.easeIn);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   InputDecoration inputStyle(String label, IconData icon) {
//     return InputDecoration(
//       hintText: label,
//       prefixIcon: Icon(icon, color: primary),
//       filled: true,
//       fillColor: surface,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(color: soft),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(color: soft),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: BorderSide(color: primary, width: 1.5),
//       ),
//     );
//   }

//   Future<void> pickDate(bool isStart) async {
//     final picked = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2100),
//       initialDate: DateTime.now(),
//     );

//     if (picked != null) {
//       setState(() {
//         if (isStart) {
//           startDate = picked;
//         } else {
//           endDate = picked;
//         }
//       });
//     }
//   }

//   String formatDate(DateTime? date) {
//     if (date == null) return "Select Date";
//     return "${date.day}/${date.month}/${date.year}";
//   }

//   // 🚀 FIXED FILE PICKER
//   Future<void> pickFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       allowMultiple: false,
//       withData: true,
//     );

//     if (result != null && result.files.single.name.isNotEmpty) {
//       final file = result.files.single;

//       setState(() {
//         fileName = file.name;
//         fileBytes = file.bytes;
//       });
//     }
//   }

//   void saveTask() {
//     if (!_formKey.currentState!.validate()) return;
//     _formKey.currentState!.save();

//     final task = TaskModel(
//       id: const Uuid().v4(),
//       name: name,
//       workType: workType,
//       status: status,
//       description: description,
//       assignedTo: assignedTo,
//       startDate: startDate,
//       endDate: endDate,

//       // ✅ FIXED
//       fileName: fileName,
//     );

//     TaskStore.addTask(task);

//     NotificationService.add("📌 New Task: $name");

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Task Created 🚀")),
//     );

//     setState(() {
//       fileName = null;
//       fileBytes = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: dark,
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   const SizedBox(height: 12),

//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: primary,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: const Text(
//                       "Create Task",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   TextFormField(
//                     decoration: inputStyle("Task Name", Icons.task),
//                     onSaved: (v) => name = v ?? '',
//                   ),

//                   const SizedBox(height: 12),

//                   TextFormField(
//                     decoration: inputStyle("Work Type", Icons.work),
//                     onSaved: (v) => workType = v ?? '',
//                   ),

//                   const SizedBox(height: 12),

//                   TextFormField(
//                     decoration: inputStyle("Assigned To", Icons.person),
//                     onSaved: (v) => assignedTo = v ?? '',
//                   ),

//                   const SizedBox(height: 12),

//                   TextFormField(
//                     decoration: inputStyle("Description", Icons.description),
//                     onSaved: (v) => description = v ?? '',
//                   ),

//                   const SizedBox(height: 16),

//                   DropdownButtonFormField(
//                     value: status,
//                     decoration: inputStyle("Status", Icons.flag),
//                     items: const [
//                       DropdownMenuItem(value: "To Do", child: Text("To Do")),
//                       DropdownMenuItem(
//                         value: "In Progress",
//                         child: Text("In Progress"),
//                       ),
//                       DropdownMenuItem(value: "Done", child: Text("Done")),
//                     ],
//                     onChanged: (v) => status = v!,
//                   ),

//                   const SizedBox(height: 16),

//                   ListTile(
//                     tileColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     leading: Icon(Icons.date_range, color: primary),
//                     title: Text(formatDate(startDate)),
//                     onTap: () => pickDate(true),
//                   ),

//                   const SizedBox(height: 10),

//                   ListTile(
//                     tileColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     leading: Icon(Icons.date_range, color: primary),
//                     title: Text(formatDate(endDate)),
//                     onTap: () => pickDate(false),
//                   ),

//                   const SizedBox(height: 16),

//                   ElevatedButton.icon(
//                     onPressed: pickFile,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: secondary,
//                       padding: const EdgeInsets.all(14),
//                     ),
//                     icon: const Icon(Icons.attach_file),
//                     label: Text(fileName ?? "Attach File"),
//                   ),

//                   const SizedBox(height: 20),

//                   InkWell(
//                     onTap: saveTask,
//                     child: Container(
//                       height: 52,
//                       decoration: BoxDecoration(
//                         color: primary,
//                         borderRadius: BorderRadius.circular(14),
//                         boxShadow: [
//                           BoxShadow(
//                             color: primary.withOpacity(0.3),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: const Center(
//                         child: Text(
//                           "Save Task",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 50),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }











































import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';

class CreateTaskScreen extends StatefulWidget {
  // هذا الباراميتر الجديد للتعديل
  final Map<String, dynamic>? taskToEdit;

  const CreateTaskScreen({
    super.key,
    this.taskToEdit,   // لو موجود = Edit Mode
  });

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String workType = '';
  String status = 'To Do';
  String description = '';
  String assignedTo = '';

  DateTime? startDate;
  DateTime? endDate;

  String? fileName;
  Uint8List? fileBytes;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final primary = const Color(0xFF3F3387);
  final secondary = const Color(0xFF766BAF);
  final soft = const Color(0xFFB3B5E1);
  final surface = const Color(0xFFFBFBFB);
  final dark = const Color(0xFF050507);

  bool get isEditMode => widget.taskToEdit != null;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // ملء الحقول في حالة التعديل
    if (isEditMode) {
      final t = widget.taskToEdit!;
      name = t['name'] ?? '';
      workType = t['workType'] ?? '';
      status = t['status'] ?? 'To Do';
      description = t['description'] ?? '';
      assignedTo = t['assignedTo'] ?? '';
      fileName = t['fileName'];

      if (t['startDate'] != null) startDate = DateTime.tryParse(t['startDate']);
      if (t['endDate'] != null) endDate = DateTime.tryParse(t['endDate']);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  InputDecoration inputStyle(String label, IconData icon) {
    return InputDecoration(
      hintText: label,
      prefixIcon: Icon(icon, color: primary),
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: soft)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: soft)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: primary, width: 1.5)),
    );
  }

  Future<void> pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) startDate = picked;
        else endDate = picked;
      });
    }
  }

  String formatDate(DateTime? date) => date == null ? "Select Date" : "${date.day}/${date.month}/${date.year}";

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        fileBytes = result.files.single.bytes;
      });
    }
  }

  Future<void> saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      if (isEditMode) {
        await FirebaseFirestore.instance
            .collection("tasks")
            .doc(widget.taskToEdit!['id'])
            .update({
              "name": name,
              "workType": workType,
              "status": status,
              "description": description,
              "assignedTo": assignedTo,
              "startDate": startDate?.toIso8601String(),
              "endDate": endDate?.toIso8601String(),
              "fileName": fileName,
              "updatedAt": DateTime.now().toIso8601String(),
            });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task Updated Successfully")),
        );
      } else {
        final id = const Uuid().v4();
        final task = {
          "id": id,
          "name": name,
          "workType": workType,
          "status": status,
          "description": description,
          "assignedTo": assignedTo,
          "startDate": startDate?.toIso8601String(),
          "endDate": endDate?.toIso8601String(),
          "fileName": fileName,
          "createdAt": DateTime.now().toIso8601String(),
        };

        await FirebaseFirestore.instance.collection("tasks").doc(id).set(task);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task Created 🚀")),
        );
      }

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      isEditMode ? "Edit Task" : "Create Task",
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(decoration: inputStyle("Task Name", Icons.task), initialValue: name, onChanged: (v) => name = v),
                  const SizedBox(height: 12),
                  TextFormField(decoration: inputStyle("Work Type", Icons.work), initialValue: workType, onChanged: (v) => workType = v),
                  const SizedBox(height: 12),
                  TextFormField(decoration: inputStyle("Assigned To", Icons.person), initialValue: assignedTo, onChanged: (v) => assignedTo = v),
                  const SizedBox(height: 12),
                  TextFormField(decoration: inputStyle("Description", Icons.description), initialValue: description, onChanged: (v) => description = v),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: status,
                    decoration: inputStyle("Status", Icons.flag),
                    items: const [
                      DropdownMenuItem(value: "To Do", child: Text("To Do")),
                      DropdownMenuItem(value: "In Progress", child: Text("In Progress")),
                      DropdownMenuItem(value: "Done", child: Text("Done")),
                    ],
                    onChanged: (v) => setState(() => status = v!),
                  ),

                  // const SizedBox(height: 16),
                  // ListTile(tileColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), leading: Icon(Icons.date_range, color: primary), title: Text(formatDate(startDate)), onTap: () => pickDate(true)),
                  // const SizedBox(height: 10),
                  // ListTile(tileColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), leading: Icon(Icons.date_range, color: primary), title: Text(formatDate(endDate)), onTap: () => pickDate(false)),


                  const SizedBox(height: 16),

                  // Start Date
                  ListTile(
                    tileColor: surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    leading: Icon(Icons.calendar_today, color: primary),
                    title: Text(
                      startDate == null 
                          ? "Start Date" 
                          : "Start Date: ${formatDate(startDate)}",
                      style: TextStyle(
                        color: startDate == null ? Colors.grey[600] : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => pickDate(true),
                  ),

                  const SizedBox(height: 12),

                  // End Date
                  ListTile(
                    tileColor: surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    leading: Icon(Icons.calendar_today, color: primary),
                    title: Text(
                      endDate == null 
                          ? "End Date" 
                          : "End Date: ${formatDate(endDate)}",
                      style: TextStyle(
                        color: endDate == null ? Colors.grey[600] : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => pickDate(false),
                  ),

                  const SizedBox(height: 20),


                  const SizedBox(height: 16),
                  ElevatedButton.icon(onPressed: pickFile, style: ElevatedButton.styleFrom(backgroundColor: secondary), icon: const Icon(Icons.attach_file), label: Text(fileName ?? "Attach File")),

                  const SizedBox(height: 30),
                  InkWell(
                    onTap: saveTask,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))]),
                      child: Center(
                        child: Text(
                          isEditMode ? "Update Task" : "Save Task",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}








































































