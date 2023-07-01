import 'package:employee_task/routing/routing_name.dart';
import 'package:employee_task/view/add_empl_details.dart';
import 'package:employee_task/view/home_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> navigatorRoutes = {
  toHomePage: (context) => const HomePage(),
  toAddEmployeeDetails: (context) => const AddEmployeeDetails()
};
