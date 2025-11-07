import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quanto_vale_app/preferences/imoveis_preferences.dart';
import 'package:quanto_vale_app/telas/login/tela_login.dart';
import 'package:shared_preferences/shared_preferences.dart';





Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quanto vale APP',
      home: TelaLogin(),
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),

    );
  }
}
