import 'package:flutter/material.dart';
import 'package:provider5_demo/models/employee.dart';
import 'package:provider5_demo/services/DatabaseHelper.dart';
import 'package:provider5_demo/views/screens/employee_details.dart';
import 'package:provider5_demo/views/widgets/text_field_input.dart';

class UpdateEmployee extends StatefulWidget {
  final String appBarTitle;
  final Employee employee;

  UpdateEmployee({this.appBarTitle, this.employee});

  @override
  _UpdateEmployeeState createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Employee employee;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController functionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstNameController.text = widget.employee.firstName;
    lastNameController.text = widget.employee.lastName;
    emailController.text = widget.employee.email;
    functionController.text = widget.employee.function;

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
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

                TextFieldInput(widget.employee, "FirstName"),
                TextFieldInput(widget.employee, "LastName"),
                TextFieldInput(widget.employee, "Email"),
                TextFieldInput(widget.employee, "Function"),
                // first Element
                // Padding(
                //   padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                //   child: TextField(
                //     controller: firstNameController,
                //     style: TextStyle(height: 1.0),
                //     onChanged: (value) {
                //       debugPrint('Something changed in Firstname Text Field');
                //       updateEmployee(firstNameController);
                //     },
                //     decoration: InputDecoration(
                //         labelText: 'Firstname',
                //         labelStyle: TextStyle(fontSize: 15),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5.0))),
                //   ),
                // ),

                // Fifth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Update',
                              textScaleFactor: 1.5,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Update button clicked");
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
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
    Navigator.pop(context, true);
  }

  // Update the title of employee object
  void updateEmployee(varController) {
    if (varController == firstNameController) {
      widget.employee.firstName = firstNameController.text;
    } else if (varController == lastNameController) {
      widget.employee.lastName = lastNameController.text;
    } else if (varController == emailController) {
      widget.employee.email = emailController.text;
      print(widget.employee.email);
    } else if (varController == functionController) {
      widget.employee.function = functionController.text;
    }
  }

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
      _showAlertDialog('Status', 'Employee update Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem updating Employee');
    }
  }

//  void _delete() async {
//    moveToLastScreen();
//
//    // Case 1: If user is trying to delete the NEW employee i.e. he has come to
//    // the detail page by pressing the FAB of employeeList page.
//    if (employee.id == null) {
//      _showAlertDialog('Status', 'No employee was deleted');
//      return;
//    }
//
//    // Case 2: User is trying to delete the old employee that already has a valid ID.
//    int result = await helper.deleteEmployee(employee.id);
//    if (result != 0) {
//      _showAlertDialog('Status', 'employee Deleted Successfully');
//    } else {
//      _showAlertDialog('Status', 'Error Occured while Deleting employee');
//    }
//  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
