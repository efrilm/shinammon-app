class Home {
  final String homeId;
  final String noHome;
  final String typeHome;
  final String priceHome;
  final String statusHome;

  Home(
      {this.homeId = '',
      this.noHome = '',
      this.typeHome = '',
      this.priceHome = '',
      this.statusHome = ''});

  factory Home.fromJson(Map response) {
    return Home(
      homeId: response['id_home'],
      noHome: response['no_home'],
      typeHome: response['type_home'],
      priceHome: response['price'],
      statusHome: response['status_home'],
    );
  }
}
