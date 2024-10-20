import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:traningfirebase/loginScreen.dart';
import 'package:traningfirebase/splach.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner:false,
        home: Splach(),));
}

