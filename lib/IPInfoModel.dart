class IPInfoModel{
  final status;
  final country;
  final countryCode;
  final regionName;
  final city;
  final zip;
  final lat;
  final lon;
  final timezone;
  final isp;
  final org;
  final as;
  final query;

  String get getStatus => status;
  String get getCountry => country;
  String get getCountryCode => countryCode;
  String get getRegionName => regionName;
  String get getCity => city;
  String get getZip => zip;
  String get getLat => lat;
  String get getLon => lon;
  String get getTimezone => timezone;
  String get getISP => isp;
  String get getOrg => org;
  String get getAs => as;
  String get getQuery => query;
 
  IPInfoModel(this.status, this.country, this. countryCode, this.regionName, this.city, this.zip,this.lat, this.lon, this.timezone, this.isp, this.org, this.as, this.query);

  factory IPInfoModel.fromJson(Map<String, dynamic> json){
    return IPInfoModel(
      json["status"],
      json["country"],
      json["countryCode"],
      json["regionName"],
      json["city"],
      json["zip"],
      json["lat"],
      json["lon"],
      json["timezone"],
      json["isp"],
      json["org"],
      json["as"],
      json["query"],
    );
  }
}

