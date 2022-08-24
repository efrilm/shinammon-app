class Absen {
  final String absentId;
  final String image;
  final String note;
  final String date;
  final String status;
  final String userId;
  final String userName;

  Absen({
    this.absentId = '',
    this.image = '',
    this.note = '',
    this.date = '',
    this.status = '',
    this.userId = '',
    this.userName = '',
  });

  factory Absen.fromJson(Map response) {
    return Absen(
      absentId: response['id_absent'],
      image: response['image'],
      date: response['date'],
      note: response['note'],
      status: response['status'],
      userId: response['user_id'],
      userName: response['user_name'],
    );
  }
}
