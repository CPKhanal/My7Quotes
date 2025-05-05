import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'utils/bulk_upload.dart'; // add this might need later

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "ENTER_YOUR_API_KEY",
      authDomain: "ENTER_YOUR_AUTH_DOMAIN",
      projectId: "ENTER_YOUR_PROJECT_ID",
      storageBucket: "ENTER_YOUR_STORAGE_BUCKET",
      messagingSenderId: "ENTER_YOUR_MESSAGING_SENDER_ID",
      appId: "ENTER_YOUR_APP_ID",
      measurementId: "ENTER_YOUR_MEASUREMENT_ID",
    ),
  );
  // await uploadQuotesFromTxt(); // ⚠️ Run ONCE only might need later
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My7Quotes',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
