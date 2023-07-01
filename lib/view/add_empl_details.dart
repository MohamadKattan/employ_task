import 'package:employee_task/components/custom_appbar.dart';
import 'package:employee_task/components/custom_failed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_bottom_bar.dart';
import '../components/custom_drop_btn.dart';
import '../components/date_paicker.dart';
import '../controller/mixin.dart';
import '../controller/state_mangment.dart';

class AddEmployeeDetails extends StatelessWidget {
  const AddEmployeeDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: custoAppBar('Add Employee Details'),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customTextFailed(
                  margin: 12.0,
                  controller: nameControler,
                ),
                Consumer<EmployeeStateMangment>(
                  builder: (context, value, child) {
                    return customDropButton(context, value);
                  },
                ),
                datePicker(context),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: customNavigationBar(context, nameControler.text)),
            Consumer<EmployeeStateMangment>(
              builder: (context, val, child) {
                return listOfItemDropDownBtn(context, val);
              },
            ),
          ],
        ),
      ),
    );
  }
}
