import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/features/onboarding/views/welcome_screen.dart';

import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'Habit Tracker',
      home: const WelcomeScreen(),
    );
  }
}

// class MeditationScreen extends StatelessWidget {
//   const MeditationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.pastelGreen,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Icon(Icons.close),
//               ),

//               const SizedBox(height: 20),

//               Text(
//                 "Meditation",
//                 style: GoogleFonts.poppins(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 40),

//               const Icon(
//                 Icons.self_improvement,
//                 size: 100,
//                 color: Colors.black,
//               ),

//               const SizedBox(height: 30),

//               Text(
//                 "34 min 46 s",
//                 style: GoogleFonts.poppins(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 30),

//               infoTile(Icons.music_note, "Calm music can help you"),
//               infoTile(Icons.air, "Mindful breathing helps you relax"),
//               infoTile(Icons.water_drop, "Water is important"),

//               const Spacer(),

//               Container(
//                 height: 60,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     "Finish",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget infoTile(IconData icon, String text) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(children: [Icon(icon), const SizedBox(width: 10), Text(text)]),
//     );
//   }
// }
