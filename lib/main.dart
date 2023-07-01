import 'package:employee_task/routing/routing_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/state_mangment.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => EmployeeStateMangment()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: navigatorRoutes,
    );
  }
}
