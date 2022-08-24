class UserModel {
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? level;
  String? projectCode;

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.level,
    this.projectCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> responseData) {
    return UserModel(
      userId: responseData['id_user'],
      name: responseData['user_name'],
      email: responseData['email'],
      phone: responseData['no_telp'],
      level: responseData['level'],
      projectCode: responseData['projectCode'],
    );
  }
}
