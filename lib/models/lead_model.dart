  class Lead {
    final String leadId;
    final String fullName;
    final String noWhatsapp;
    final String address;
    final String note;
    final String source;
    final String salesId;
    final String markomId;
    final String? homeId;
    final String dateAdd;
    final String updateDate;
    final String day;
    final String status;
    final String? paymentMethod;
    final String projectCode;
    final String? noHome;
    final String? typeHome;
    final String? priceHome;

    Lead({
      this.leadId = '',
      this.fullName = '',
      this.noWhatsapp = '',
      this.address = '',
      this.note = '',
      this.source = '',
      this.salesId = '',
      this.markomId = '',
      this.homeId,
      this.dateAdd = '',
      this.updateDate = '',
      this.day = '',
      this.status = '',
      this.paymentMethod,
      this.projectCode = '',
      this.noHome = '',
      this.typeHome = '',
      this.priceHome = '',
    });

    factory Lead.fromJson(Map response) {
      return Lead(
        leadId: response['id_lead'],
        fullName: response['full_name'],
        noWhatsapp: response['no_whatsapp'],
        address: response['address'],
        status: response['status'],
        source: response['source'],
        note: response['note'],
        dateAdd: response['date_add'],
        updateDate: response['update_date'],
        day: response['day'],
        salesId: response['sales_id'],
        markomId: response['markom_id'],
        homeId: response['home_id'],
        paymentMethod: response['payment_method'],
        projectCode: response['project_code'],
        noHome: response['no_home'],
        typeHome: response['type_home'],
        priceHome: response['price'],
      );
    }
  }
