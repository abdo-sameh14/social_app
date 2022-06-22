class UsersModel{
  String? firstName;
  String? lastName;
  String? phone;
  String? uId;

  UsersModel(
      this.firstName,
      this.lastName,
      this.phone,
      this.uId,
      );

  UsersModel.fromJson(Map<String, dynamic>json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap(){
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'uId': uId,
    };
  }
}