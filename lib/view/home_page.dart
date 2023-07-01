import 'package:employee_task/controller/local_db.dart';
import 'package:employee_task/controller/state_mangment.dart';
import 'package:employee_task/routing/routing_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../components/custom_appbar.dart';
import '../components/custom_floating_btn.dart';
import '../controller/mixin.dart';
import '../routing/routing_method.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    EmployeeDataBase().readData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: custoAppBar('Employ List'),
        body: Consumer<EmployeeStateMangment>(
          builder: (context, value, child) {
            if (value.listOfEmploy!.isEmpty) {
              return noEmployerYet();
            } else {
              return listOfEmploys(value);
            }
          },
        ),
        floatingActionButton: customFloatinBtn(
          navToPage: () {
            isEdit = false;
            navigatorByNameRouting(
                context: context, routeName: toAddEmployeeDetails);
          },
        ),
      ),
    );
  }

  // this widget for display list of employer if not empty
  Widget listOfEmploys(EmployeeStateMangment value) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: value.listOfEmploy?.length,
      itemBuilder: (_, i) {
        return Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  EmployeeDataBase()
                      .delete(value.listOfEmploy?[i].employeeId ?? 0, context)
                      .whenComplete(() {
                    value.deleteAnEmployee(i);
                  });
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: (_) {
                  isEdit = true;
                  index = i;
                  value.getUserId(value.listOfEmploy?[i].employeeId ?? 0);
                  navigatorByNameRouting(
                      context: context, routeName: toAddEmployeeDetails);
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  value.listOfEmploy?[i].employeeName ?? 'null',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              subtitle: Text(
                "${value.listOfEmploy?[i].employeeRole ?? 'null'}\n"
                'From : ${value.listOfEmploy?[i].startDate}\n'
                'To : ${value.listOfEmploy?[i].endDate}',
                style: TextStyle(color: Colors.grey.shade500, height: 1.5),
              ),
            ),
          ),
        );
      },
    );
  }

// this widget if no Employer yet
  Widget noEmployerYet() {
    return Center(child: displayImage(imageName: 'noEployer.png'));
  }
}
