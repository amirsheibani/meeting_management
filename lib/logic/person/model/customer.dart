class Customer {
  Customer({
      this.id, 
      this.titlePersian, 
      this.titleEnglish, 
      this.descriptionPersian, 
      this.descriptionEnglish, 
      this.financialCode, 
      this.identificationNumber, 
      this.registrationNumber, 
      this.city, 
      this.province, 
      this.postalCode, 
      this.website, 
      this.address, 
      this.employeeCount, 
      this.industryId, 
      this.mainCallInfo, 
      this.faxNumber, 
      this.organizationUnitId,});

  Customer.fromJson(dynamic json) {
    id = json['id'];
    titlePersian = json['titlePersian'];
    titleEnglish = json['titleEnglish'];
    descriptionPersian = json['descriptionPersian'];
    descriptionEnglish = json['descriptionEnglish'];
    financialCode = json['financialCode'];
    identificationNumber = json['identificationNumber'];
    registrationNumber = json['registrationNumber'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postalCode'];
    website = json['website'];
    address = json['address'];
    employeeCount = json['employeeCount'];
    industryId = json['industryId'];
    mainCallInfo = json['mainCallInfo'];
    faxNumber = json['faxNumber'];
    organizationUnitId = json['organizationUnitId'];
  }
  int? id;
  String? titlePersian;
  String? titleEnglish;
  dynamic descriptionPersian;
  dynamic descriptionEnglish;
  dynamic financialCode;
  String? identificationNumber;
  String? registrationNumber;
  String? city;
  String? province;
  String? postalCode;
  dynamic website;
  String? address;
  int? employeeCount;
  dynamic industryId;
  String? mainCallInfo;
  dynamic faxNumber;
  int? organizationUnitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['titlePersian'] = titlePersian;
    map['titleEnglish'] = titleEnglish;
    map['descriptionPersian'] = descriptionPersian;
    map['descriptionEnglish'] = descriptionEnglish;
    map['financialCode'] = financialCode;
    map['identificationNumber'] = identificationNumber;
    map['registrationNumber'] = registrationNumber;
    map['city'] = city;
    map['province'] = province;
    map['postalCode'] = postalCode;
    map['website'] = website;
    map['address'] = address;
    map['employeeCount'] = employeeCount;
    map['industryId'] = industryId;
    map['mainCallInfo'] = mainCallInfo;
    map['faxNumber'] = faxNumber;
    map['organizationUnitId'] = organizationUnitId;
    return map;
  }

}