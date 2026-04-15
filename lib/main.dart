// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'presentation/screens/create_task_screen.dart';
// import 'features/task/data/models/notification/notification_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// // ...

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MainScreen(),
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int index = 0;

//   final pages = const [CreateTaskScreen(), NotificationScreen()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[index],

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: index,
//         onTap: (i) => setState(() => index = i),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.add), label: "Create"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: "Notifications",
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// import 'presentation/screens/create_task_screen.dart';
// import 'features/task/data/models/notification/notification_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MainScreen(),
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int index = 0;

//   final pages = const [
//     CreateTaskScreen(),
//     NotificationScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[index],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: index,
//         onTap: (i) => setState(() => index = i),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: "Create",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: "Notifications",
//           ),
//         ],
//       ),
//     );
//   }
// }





















































import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'presentation/screens/create_task_screen.dart';
import 'presentation/screens/tasks_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final pages = const [
    CreateTaskScreen(),
    TasksListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Tasks",
          ),
        ],
      ),
    );
  }
}





















// import 'package:flutter/material.dart';
// import 'presentation/screens/create_task_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CreateTaskScreen(),
//     );
//   }
// }