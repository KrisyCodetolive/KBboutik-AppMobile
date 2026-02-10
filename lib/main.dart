import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kbboutik_v04/pages/productPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart'; // généré par flutterfire configure


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: 'https://nwknmpiunonduxznsfop.supabase.co',  // ton URL Supabase
    anonKey: 'sb_publishable_3QaAZ4-a1S5fEt60czYOCw_VpWbMgVc',            // ta clé anon
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de produits',
      home: ProductPage(),
    );
  }
}


