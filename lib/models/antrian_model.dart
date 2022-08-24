class Antrian {
  final String? userId;
  final String? nameUser;
  final String? updateDate;
  final String? photo;

  Antrian({this.userId, this.nameUser, this.updateDate, this.photo});

  factory Antrian.fromJson(Map response) {
    return Antrian(
      userId: response['id_user'],
      nameUser: response['user_name'],
      updateDate: response['update_date'],
      photo: response['photo'],
    );
  }
}
