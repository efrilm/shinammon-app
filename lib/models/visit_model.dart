class Visit {
  final String visitId;
  final String leadId;
  final String note;
  final String visitDate;
  final String createDate;
  final String updateDate;
  final String statusVisit;
  final String projectCode;
  final String fullName;
  final String noWhatsapp;
  final String address;
  final String source;
  final String salesId;
  final String markomId;

  Visit({
    this.visitId = '',
    this.leadId = '',
    this.note = '',
    this.visitDate = '',
    this.createDate = '',
    this.updateDate = '',
    this.statusVisit = '',
    this.projectCode = '',
    this.fullName = '',
    this.noWhatsapp = '',
    this.address = '',
    this.source = '',
    this.salesId = '',
    this.markomId = '',
  });

  factory Visit.fromJson(Map response) {
    return Visit(
      visitId: response['id_visit'],
      leadId: response['lead_id'],
      note: response['note'],
      visitDate: response['visit_date'],
      createDate: response['create_date'],
      updateDate: response['update_date'],
      statusVisit: response['status_visit'],
      projectCode: response['project_code'],
      fullName: response['full_name'],
      noWhatsapp: response['no_whatsapp'],
      source: response['source'],
      salesId: response['sales_id'],
      markomId: response['markom_id'],
    );
  }
}
