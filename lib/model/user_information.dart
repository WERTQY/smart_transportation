class UserInformation {
  String? userId;
  String? email;
  String? name;
  int? age;
  String? gender;
  String? race;
  String? phone;
  bool? firstTimeLogin;
  bool? isDriver;
  String? carModel;
  String? carPlate;
  bool? online;

  UserInformation(
      {this.userId,
      this.email,
      this.name,
      this.age,
      this.gender,
      this.race,
      this.phone,
      this.firstTimeLogin,
      this.isDriver,
      this.carModel,
      this.carPlate,
      this.online});

  UserInformation.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    race = json['race'];
    phone = json['phone'];
    firstTimeLogin = json['firstTimeLogin'];
    isDriver = json['isDriver'];
    carModel = json['carModel'];
    carPlate = json['carPlate'];
    online = json['online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['race'] = this.race;
    data['phone'] = this.phone;
    data['firstTimeLogin'] = this.firstTimeLogin;
    data['isDriver'] = this.isDriver;
    data['carModel'] = this.carModel;
    data['carPlate'] = this.carPlate;
    data['online'] = this.online;
    return data;
  }

  void reset() {
    userId = null;
    email = null;
    name = "";
    age = 0;
    gender = "";
    race = "";
    phone = "";
    firstTimeLogin = true;
    isDriver = false;
    carModel = "";
    carPlate = "";
    online = false;
  }
}