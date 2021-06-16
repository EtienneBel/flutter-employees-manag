import "package:flutter/material.dart";
import 'package:provider5_demo/models/employee.dart';
import 'package:provider5_demo/services/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

import 'add_employee.dart';
import 'employee_details.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Employee> employeeList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (employeeList == null) {
      employeeList = [];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee's Management"),
        centerTitle: true,
      ),
      body: getEmployeeListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // debugPrint('FAB clicked');
          navigateToAdd("Add a employee");
        },
        tooltip: 'To add a employee',
        child: Icon(Icons.add),
      ),
    );
  }

  void navigateToDetail(Employee employee, String title) async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EmployeeDetails(employee: employee, appBarTitle: title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void navigateToAdd(String title) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AddEmployee(appBarTitle: title);
      }),
    );

    if (result == true) {
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _delete(BuildContext context, Employee employee) async {
    int result = await databaseHelper.deleteEmployee(employee.id);
    if (result != 0) {
      _showSnackBar(context, "Employee Deleted Successfully");
      updateListView();
    }
  }

  String getFirstLetter(String s) {
    return s.substring(0, 2);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Employee>> employeeListFuture =
      databaseHelper.getEmployeeList();
      employeeListFuture.then((employeeList) {
        setState(() {
          this.employeeList = employeeList;
          this.count = employeeList.length;
        });
      });
    });
  }

  ListView getEmployeeListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 4.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(
                  getFirstLetter("EM"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                this.employeeList[position].function,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(this.employeeList[position].firstName +
                  " " +
                  this.employeeList[position].lastName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {
                      _delete(context, employeeList[position]);
                    },
                  )
                ],
              ),
              onTap: () {
                // debugPrint("ListTile Tapped");
                navigateToDetail(
                    this.employeeList[position], 'Employee Details');
              },
            ),
          );
        });
  }
}
