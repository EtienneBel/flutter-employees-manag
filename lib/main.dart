import 'package:flutter/material.dart';
import 'package:provider5_demo/views/screens/employee_list.dart';

import 'models/employee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Employee's Management",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeList(),
    );
  }
}
