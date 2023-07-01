import 'package:employee_task/model/employees.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'local_db.dart';
import 'state_mangment.dart';

bool isEdit = false;
int? index;
TextEditingController nameControler = TextEditingController();
// this method for display images
Widget displayImage(
    {required String imageName, double? width, double? height, BoxFit? fit}) {
  return SizedBox(
    child: Image.asset('assets/images/$imageName',
        width: width ?? 250.0,
        height: height ?? 250.0,
        fit: fit ?? BoxFit.contain),
  );
}

// this method for format date befor set to api
String formatDate(List<DateTime?> values) {
  String valueText = '';
  if (values.isNotEmpty) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');
  } else {
    return 'null';
  }

  return valueText;
}

// this method for display error message
void errorMessage({String? ex}) {
  Fluttertoast.showToast(
      msg: ex ?? 'Errore',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

// this method for check if data not empty befor submit to local databade
void checkBeforSubmit(BuildContext context, String nameEmployer) {
  final val = context.read<EmployeeStateMangment>();
  if (nameEmployer.isEmpty) {
    errorMessage(ex: 'Name is required');
  } else if (val.valChange == null || val.valChange == '') {
    errorMessage(ex: 'role is required');
  } else if (val.startDate == null || val.startDate == '') {
    errorMessage(ex: 'Started day is required');
  } else if (val.endDate == null || val.endDate == '') {
    errorMessage(ex: 'end day is required');
  } else {
    Employees employees = Employees(
        employeeName: nameEmployer,
        employeeRole: context.read<EmployeeStateMangment>().valChange,
        startDate: context.read<EmployeeStateMangment>().startDate,
        endDate: context.read<EmployeeStateMangment>().endDate);
    if (!isEdit) {
      EmployeeDataBase().setDataToDataBase(employees, context).whenComplete(() {
        val.addNewEmployee(employees);
        clear(context);
        Navigator.pop(context);
      });
    } else {
      EmployeeDataBase()
          .update(employees, context, val.userId ?? 0)
          .whenComplete(() {
        isEdit = false;
        val.editInfoAnEmployee(employees, index ?? 0);
        clear(context);
        Navigator.pop(context);
      });
    }
  }
}

// this method for clear form after submited
void clear(BuildContext context) {
  final val = context.read<EmployeeStateMangment>();
  nameControler.clear();
  val.updatechangeVal('');
  val.updateStartDate('');
  val.updateEndDATE('');
}
