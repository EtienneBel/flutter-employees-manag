import 'package:flutter/material.dart';
import 'package:provider5_demo/models/employee.dart';
import 'package:provider5_demo/services/DatabaseHelper.dart';
import 'package:provider5_demo/views/widgets/text_field_input.dart';

class AddEmployee extends StatefulWidget {
  final String appBarTitle;
  final Employee employee = new Employee(firstName: " ", lastName: " ", email: " ", function: " ");

  AddEmployee({this.appBarTitle});

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  DatabaseHelper helper = new DatabaseHelper();
  String photoController;

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
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: [
              TextFieldInput(widget.employee, "FirstName"),
              TextFieldInput(widget.employee, "LastName"),
              TextFieldInput(widget.employee, "Email"),
              TextFieldInput(widget.employee, "Function"),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            // debugPrint("Save button clicked");
                            _save();
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
      ),
    );
  }

// Save data to database
  void _save() async {
    moveToLastScreen();

//    employee.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (widget.employee.id != null) {
      // Case 1: Update operation
      result = await helper.updateEmployee(widget.employee);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertEmployee(widget.employee);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Employee Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Employee');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
