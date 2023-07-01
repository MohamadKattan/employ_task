import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/state_mangment.dart';

// this widget btn drop down
Widget customDropButton(BuildContext context, EmployeeStateMangment value) {
  return GestureDetector(
    onTap: () {
      context.read<EmployeeStateMangment>().updatePostionDropBtnList(0.0);
    },
    child: Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.work_outline_outlined,
                color: Colors.blue,
                size: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  value.valChange == ''
                      ? 'Select role'
                      : value.valChange ?? 'Select role',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
            size: 35.0,
          )
        ],
      ),
    ),
  );
}

// this widget list of dropDown item btn
Widget listOfItemDropDownBtn(BuildContext context, EmployeeStateMangment val) {
  const List<String> lisOfrols = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];
  return AnimatedPositioned(
    height: MediaQuery.of(context).size.height * 35 / 100,
    width: MediaQuery.of(context).size.width,
    bottom: val.dropPostionContainer,
    duration: const Duration(milliseconds: 600),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.builder(
          itemCount: lisOfrols.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                context
                    .read<EmployeeStateMangment>()
                    .updatechangeVal(lisOfrols[i]);
                context
                    .read<EmployeeStateMangment>()
                    .updatePostionDropBtnList(-500);
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: Center(child: Text(lisOfrols[i])),
              ),
            );
          }),
    ),
  );
}
