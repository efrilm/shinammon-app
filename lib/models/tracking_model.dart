class Tracking {
  final String trackingId;
  final String leadId;
  final String note;
  final String createDate;
  final String userName;

  Tracking(
      {this.trackingId = '',
      this.leadId = '',
      this.note = '',
      this.createDate = '',
      this.userName = ''});

  factory Tracking.fromJson(Map response) {
    return Tracking(
      trackingId: response['id_tracking'],
      leadId: response['lead_id'],
      note: response['note'],
      createDate: response['create_date'],
      userName: response['user_name'],
    );
  }
}
