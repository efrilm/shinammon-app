class AppUrl {
  static const String ip = 'http://192.168.1.16';
  static const String liveBaseUrl = 'https://lead.marketingbranding.id/api';
  static const String localBaseUrl = ip + '/lead-management-api/api';
  static const String baseUrl = liveBaseUrl;

  static const String imgProfileUrl =
       'https://lead.marketingbranding.id/images/profile';
  static const String imgAbsenUrl = 'https://lead.marketingbranding.id/images/absen';

  static const String project = baseUrl + '/project';

  static const String setToken = baseUrl + '/user/setToken';

  // Notification
  static const String notifAbsen = baseUrl + '/notification/absen';
  static const String notifPamit = baseUrl + '/notification/pamit';
  static const String notifLead = baseUrl + '/notification/lead';
  static const String notifFollowUp = baseUrl + '/notification/followUp';
  static const String notifVisit = baseUrl + '/notification/visit';
  static const String notifAlreadyVisit =
      baseUrl + '/notification/alreadyVisit';
  static const String notifReservation = baseUrl + '/notification/reservation';
  static const String notifBooking = baseUrl + '/notification/booking';
  static const String notifSold = baseUrl + '/notification/sold';

  // auth
  static const String signIn = baseUrl + '/auth/signin';
  static const String signUp = baseUrl + '/auth/signup';
  static const String code = baseUrl + '/auth/codeProject';

  // absen
  static const String absen = baseUrl + '/absen';
  static const String getAbsen = baseUrl + '/absen';
  static const String getAbsenToday = baseUrl + '/absen/today';

  // home
  static const String home = baseUrl + '/home';
  static const String countHome = baseUrl + '/home/count';
  static const String homeLimit = baseUrl + '/home/limit';

  // user
  static const String getUser = baseUrl + '/user/users?id=';
  static const String getUserByLevel = baseUrl + '/user/userByLevel';
  static const String antrian = baseUrl + '/user/antrian?project_code=';
  static const String editName = baseUrl + '/user/name';
  static const String editEmail = baseUrl + '/user/email';
  static const String editNoTelp = baseUrl + '/user/noTelp';
  static const String editPhoto = baseUrl + '/user/photo';
  static const String editPassword = baseUrl + '/user/password';
  static const String antrianLimit =
      baseUrl + '/user/antrianLimit?project_code=';

  // insight
  static const String getDay = baseUrl + '/insight/day?project_code=';
  static const String getWeek = baseUrl + '/insight/week?project_code=';
  static const String getMonth = baseUrl + '/insight/month?project_code=';
  static const String getDayMarkom = baseUrl + '/insight/dayMarkom';
  static const String getWeekMarkom = baseUrl + '/insight/weekMarkom';
  static const String getMonthMarkom = baseUrl + '/insight/monthMarkom';
  static const String getDaySales = baseUrl + '/insight/daySales';
  static const String getWeekSales = baseUrl + '/insight/weekSales';
  static const String getMonthSales = baseUrl + '/insight/monthSales';

  // owner
  static const String getOmset = baseUrl + '/owner/omset';
  static const String leadO = baseUrl + '/owner/lead';
  static const String leadAndHomeO = baseUrl + '/owner/leadAndHome';
  static const String visitO = baseUrl + '/owner/visit';
  static const String leadPmO = baseUrl + '/owner/leadPM';
  static const String leadLimitO = baseUrl + '/owner/leadLimit';

  // markom
  static const String leadM = baseUrl + '/markom/lead';
  static const String visitM = baseUrl + '/markom/visit';
  static const String leadPmM = baseUrl + '/markom/leadPm';
  static const String leadAndHomeM = baseUrl + '/markom/leadAndHome';
  static const String countM = baseUrl + '/markom/count';
  static const String leadLimitM = baseUrl + '/markom/leadLimit';

  // sales
  static const String leadS = baseUrl + '/sales/lead';
  static const String leadAndHomeS = baseUrl + '/sales/leadAndHome';
  static const String visitSales = baseUrl + '/sales/visit';
  static const String leadPmS = baseUrl + '/sales/leadPm';
  static const String countS = baseUrl + '/sales/count';
  static const String leadLimitS = baseUrl + '/sales/leadLimit';

  // tracking
  static const String tracking = baseUrl + '/tracking';

  // lead
  static const String addLead = baseUrl + '/lead/add';
  static const String addFollowUp = baseUrl + '/lead/addFollowUp';
  static const String addVisit = baseUrl + '/lead/addVisit';
  static const String addAlreadyVisit = baseUrl + '/lead/addAlreadyVisit';
  static const String addReservation = baseUrl + '/lead/reservation';
  static const String addBooking = baseUrl + '/lead/booking';
  static const String addSold = baseUrl + '/lead/sold';
  static const String delete = baseUrl + '/lead/deleteLead';
  static const String editLead = baseUrl + '/lead/editLead';
  static const String getDate = baseUrl + '/lead/date?id=';
  static const String getFee = baseUrl + '/lead/fee?id=';
  static const String getPayment = baseUrl + '/lead/payment?id=';
  static const String getCount = baseUrl + '/lead/count';
}
