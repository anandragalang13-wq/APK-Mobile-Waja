import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const WAJAApp());
}

class WAJAApp extends StatelessWidget {
  const WAJAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WAJA - Wayang Jawa',
      initialRoute: AppPages.INITIAL,
      routes: AppPages.routes,
    );
  }
}
