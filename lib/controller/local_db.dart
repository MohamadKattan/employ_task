import 'dart:async';

import 'package:employee_task/controller/state_mangment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../model/employees.dart';

const String dbName = 'employee.db';
const String tableEmployee = 'employee';
const String idemployer = '_id';
const String employeeNameD = 'name';
const String employeeRoleD = 'role';
const String startDateD = 'startDate';
const String endDateD = 'endDate';

class EmployeeDataBase {
// this method for open dataBase if not exist yet
  Future<Database> _initDatabase() async {
    String path = p.join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await _creatDb(db);
    });
  }

  // this method for created table of dataBase
  Future _creatDb(Database db) async {
    await db.execute('''
create table $tableEmployee (
  $idemployer integer primary key autoincrement,
  $employeeNameD text not null,
  $employeeRoleD text not null,
  $startDateD text not null,
  $endDateD text not null
  )
''');
  }

// this method for insert new data to dataBase
  Future<int> setDataToDataBase(
      Employees employees, BuildContext context) async {
    final db = await _initDatabase();
    return await db.insert(tableEmployee, employees.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // this method for got data from locale dataBase

  Future<Employees?> readData(BuildContext context) async {
    final val = Provider.of<EmployeeStateMangment>(context, listen: false);
    final db = await _initDatabase();

    List<Map<String, dynamic>> maps = await db.query(tableEmployee);
    if (maps.isNotEmpty) {
      List<Employees> employeesList =
          List.generate(maps.length, (index) => Employees.fromMap(maps[index]));
      if (context.mounted) {
        for (var element in employeesList) {
          val.addNewEmployee(element);
        }
      }
    }
    return null;
  }

  // this method for delete one user from database
  Future<int> delete(int id, BuildContext context) async {
    final db = await _initDatabase();
    return await db
        .delete(tableEmployee, where: '$idemployer = ?', whereArgs: [id]);
  }

  Future<int> update(Employees employees, BuildContext context, int id) async {
    final db = await _initDatabase();
    return await db.update(tableEmployee, employees.toMap(),
        where: '$idemployer = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // this method for close data base
  Future close() async {
    final db = await _initDatabase();
    await db.close();
  }

// this method for delete data base from device
  Future deleteAll() async {
    final dbPath = await getDatabasesPath();
    String path = p.join(dbPath, 'employee.db');
    await deleteDatabase(path);
  }
}
