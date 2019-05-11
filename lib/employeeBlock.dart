import 'dart:async';
import 'employee.dart';

class EmployeeBloc {
  //Sink to add in pipe
  //Stream to get data from pipe
  //by pipe I mean a data flow

  List<Employee> _employeeList = [
    Employee(1, "Employee One", 10000.0),
    Employee(2, "Employee Two", 22000.0),
    Employee(3, "Employee Three", 14000.0),
    Employee(4, "Employee Four", 10000.0),
    Employee(5, "Employee Five", 10000.0),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  //for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //getters

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;
  Sink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  Sink<Employee> get employeeSalaryIncrementSink =>
      _employeeSalaryIncrementStreamController.sink;
  Sink<Employee> get employeeSalaryDecrementSink =>
      _employeeSalaryDecrementStreamController.sink;



  EmployeeBloc() { 
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  void _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * 20/100;
    _employeeList[employee.id-1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  void _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 20/100;
    _employeeList[employee.id-1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }
}
