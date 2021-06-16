import 'package:flutter/material.dart';
import 'package:provider5_demo/models/employee.dart';
import 'package:provider5_demo/services/DatabaseHelper.dart';
import 'package:provider5_demo/views/screens/update_employee.dart';

class EmployeeDetails extends StatefulWidget {
  final String appBarTitle;
  final Employee employee;
  EmployeeDetails({this.appBarTitle, this.employee});

  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Employee employee;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          moveToLastScreen();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.appBarTitle),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                // First Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "Firstname : " + widget.employee.firstName,
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "Lastname : " + widget.employee.lastName,
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "Email : " + widget.employee.email,
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(
                    "Poste : " + widget.employee.function,
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Update',
                              textScaleFactor: 1.5,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Update button clicked");
                              navigateToUpdate(widget.employee, 'Update Employee');
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void navigateToUpdate(Employee employee, String title) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UpdateEmployee(employee: employee, appBarTitle: title);
    }));
  }
}
