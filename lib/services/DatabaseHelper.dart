import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:provider5_demo/models/employee.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String employeeTable = 'employee';
  String colId = 'id';
  String colFirstName = 'firstName';
  String colLastName = 'lastName';
  String colEmail = 'email';
  String colFunction = 'function';
  String colPhoto = 'photo';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'employeeImages.db';

    // Open/create the database at a given path
    var employeeDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return employeeDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $employeeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colFirstName TEXT, '
            '$colLastName TEXT, $colEmail TEXT, $colFunction TEXT, $colPhoto TEXT)');
  }

  // Fetch Operation: Get all employee objects from database
  Future<List<Map<String, dynamic>>> getEmployeeMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $employeeTable order by $colTitle ASC');
    var result = await db.query(employeeTable, orderBy: '$colFirstName ASC');
    return result;
  }

  // Insert Operation: Insert a employee object to database
  Future<int> insertEmployee(Employee employee) async {
    Database db = await this.database;
    var result = await db.insert(employeeTable, employee.toMap());
    return result;
  }

  // Update Operation: Update a employee object and save it to database
  Future<int> updateEmployee(Employee employee) async {
    var db = await this.database;
    var result = await db.update(employeeTable, employee.toMap(),
        where: '$colId = ?', whereArgs: [employee.id]);
    return result;
  }

  Future<int> updateEmployeeCompleted(Employee employee) async {
    var db = await this.database;
    var result = await db.update(employeeTable, employee.toMap(),
        where: '$colId = ?', whereArgs: [employee.id]);
    return result;
  }

  // Delete Operation: Delete a employee object from database
  Future<int> deleteEmployee(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete('DELETE FROM $employeeTable WHERE $colId = $id');
    return result;
  }

  // Get number of employee objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $employeeTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'employee List' [ List<Employee> ]
  Future<List<Employee>> getEmployeeList() async {
    var employeeMapList =
    await getEmployeeMapList(); // Get 'Map List' from database
    int count =
        employeeMapList.length; // Count the number of map entries in db table

    List<Employee> employeeList = [];
    // For loop to create a 'employee List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      employeeList.add(Employee.fromMapObject(employeeMapList[i]));
    }
    return employeeList;
  }
}