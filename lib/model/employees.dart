
const String idemployer = '_id';
const String employeeNameD = 'name';
const String employeeRoleD = 'role';
const String startDateD = 'startDate';
const String endDateD = 'endDate';

class Employees {
  int? employeeId;
  String? employeeName;
  String? employeeRole;
  String? startDate;
  String? endDate;
  Employees(
      {this.employeeId,
      required this.employeeName,
      required this.employeeRole,
      required this.startDate,
      required this.endDate});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      employeeNameD: employeeName,
      employeeRoleD: employeeRole,
      startDateD: startDate,
      endDateD: endDate
    };
    if (employeeId != null) {
      map['_id'] = employeeId;
    }
    return map;
  }

  Employees.fromMap(Map<String, dynamic> map) {
    employeeId = map[idemployer];
    employeeName = map[employeeNameD];
    employeeRole = map[employeeRoleD];
    startDate = map[startDateD];
    endDate = map[endDateD];
  }
}
