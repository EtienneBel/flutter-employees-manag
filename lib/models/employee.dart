class Employee {
  int id;
  String firstName;
  String lastName;
  String email;
  String function;

  Employee.withId(
      {this.id, this.firstName, this.lastName, this.email, this.function});

  Employee({this.firstName, this.lastName, this.email, this.function});

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['function'] = function;

    return map;
  }

  // Extract a object from a Map object
  Employee.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.email = map['email'];
    this.function = map['function'];
  }
}
