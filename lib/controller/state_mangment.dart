import 'package:flutter/foundation.dart';

import '../model/employees.dart';

class EmployeeStateMangment with ChangeNotifier, DiagnosticableTreeMixin {
  //=================add-edit-delete new Employee===================
  final List<Employees> _listOfEmploy = [];
  List<Employees>? get listOfEmploy => _listOfEmploy;
  int? _userId;
  int? get userId => _userId;

  void addNewEmployee(Employees employees) {
    _listOfEmploy.add(employees);
    notifyListeners();
  }

  void editInfoAnEmployee(Employees employees, int index) {
    _listOfEmploy[index].employeeName = employees.employeeName;
    _listOfEmploy[index].employeeRole = employees.employeeRole;
    _listOfEmploy[index].startDate = employees.startDate;
    _listOfEmploy[index].endDate = employees.endDate;
    notifyListeners();
  }

  void getUserId(int val) {
    _userId = val;
    notifyListeners();
  }

  void deleteAnEmployee(int index) {
    _listOfEmploy.removeAt(index);
    notifyListeners();
  }

//========== dropDownBtn select role + postion val of drop lIST====

  String? _changeVal;
  String? get valChange => _changeVal;

  void updatechangeVal(String valOf) {
    _changeVal = valOf;
    notifyListeners();
  }

  double _dropPostionContainer = -500.0;
  double get dropPostionContainer => _dropPostionContainer;

  void updatePostionDropBtnList(double valOfPostion) {
    _dropPostionContainer = valOfPostion;
    notifyListeners();
  }

  //========================date picker==========================
  // list of date for pick and set in dailoge api filtter
  List<DateTime?> _listOfDate = [DateTime.now()];
  List<DateTime?> get listOfDate => _listOfDate;
  void updateListOfDate(List<DateTime?> valOf) {
    _listOfDate = valOf;
    notifyListeners();
  }

  // start and end  date
  String? _startDate;
  String? _endDate;
  String? get startDate => _startDate;
  String? get endDate => _endDate;

  void updateStartDate(String valOf) {
    _startDate = valOf;
    notifyListeners();
  }

  void updateEndDATE(String valLOf) {
    _endDate = valLOf;
    notifyListeners();
  }
}
