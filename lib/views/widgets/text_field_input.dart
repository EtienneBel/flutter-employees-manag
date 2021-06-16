import 'package:flutter/material.dart';
import 'package:provider5_demo/models/employee.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textController = new TextEditingController();
  final Employee employee;
  final String attribut;

  TextFieldInput(this.employee, this.attribut);

  @override
  Widget build(BuildContext context) {
    fillForm();
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: TextField(
        controller: textController,
        style: TextStyle(height: 1.0),
        onChanged: (value) {
          checkProperty();
        },
        decoration: InputDecoration(
          labelText: attribut,
          labelStyle: TextStyle(fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  void checkProperty() {
    if (attribut == "FirstName") {
      employee.firstName = textController.text;
    } else if (attribut == "LastName") {
      employee.lastName = textController.text;
    } else if (attribut == "Email") {
      employee.email = textController.text;
    } else if (attribut == "Function") {
      employee.function = textController.text;
    }
  }

  void fillForm() {
    if (employee.id != null) {
      if (attribut == "FirstName") {
        textController.text = employee.firstName;
      } else if (attribut == "LastName") {
        textController.text = employee.lastName;
      } else if (attribut == "Email") {
        textController.text = employee.email;
      } else if (attribut == "Function") {
        textController.text = employee.function;
      }
    }
  }
}
