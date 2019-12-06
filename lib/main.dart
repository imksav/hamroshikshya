import 'package:flutter/material.dart';
import 'package:hamroshikshya/menu_dashboard_layout.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamro Shikhya',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: MenuDashboardPage(),
      );
  }
}