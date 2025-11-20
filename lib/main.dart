import 'package:attendance_app/wrapper/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBeYilVUJa8nKBneburVmhuu8PpnTThUN0",
      appId: "1:807099595129:android:fe66b8eeab0b3a42c017a8",
      messagingSenderId: "807099595129",
      projectId: "attendance-app-75ddb",
    ),
  );
  runApp(attendance_app());
}


class attendance_app extends StatelessWidget {
  const attendance_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
        )
      ),
      home: AuthWrapper(),
    );
  }
}