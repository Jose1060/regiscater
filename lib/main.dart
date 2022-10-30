import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:regiscater/firebase_options.dart';
import 'package:regiscater/pages/add_client.dart';
import 'package:regiscater/pages/home_screen.dart';
import 'package:regiscater/pages/list_info_client_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Regiscater',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const HomeScreen(),
        '/ls': (context) => const ListClientScreen(),
        '/add': (context) => const AddClientScreen()
      },
    );
  }
}
