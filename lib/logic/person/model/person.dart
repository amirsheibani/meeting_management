

import 'customer.dart';
import 'image_model.dart';
import 'organization_unit.dart';

class Person {
  Person({
    this.id,
    this.code,
    this.type,
    this.firstname,
    this.lastname,
    this.firstNamePersian,
    this.lastNamePersian,
    this.firstNameEnglish,
    this.lastNameEnglish,
    this.positionPersian,
    this.positionEnglish,
    this.titlePersian,
    this.titleEnglish,
    this.email,
    this.sexType,
    this.mobileNumber,
    this.nationalityId,
    this.nationalCode,
    this.birthCertificateNumber,
    this.birthDate,
    this.birthCityId,
    this.birthProvinceId,
    this.birthCountryId,
    this.marriedStatusId,
    this.residenceCityId,
    this.residenceProvinceId,
    this.residenceCountryId,
    this.organizationUnitId,
    this.role,
    this.organizationUnit,
    this.customer,
    this.image,
    this.imageId,
    this.imageOnChanged,
  });

  Person.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    firstname = json['firstName'];
    lastname = json['lastName'];
    firstNamePersian = json['firstNamePersian'];
    lastNamePersian = json['lastNamePersian'];
    firstNameEnglish = json['firstNameEnglish'];
    lastNameEnglish = json['lastNameEnglish'];
    positionPersian = json['positionPersian'];
    positionEnglish = json['positionEnglish'];
    titlePersian = json['titlePersian'];
    titleEnglish = json['titleEnglish'];
    email = json['email'];
    sexType = json['sexType'];
    mobileNumber = json['mobileNumber'];
    nationalityId = json['nationalityId'];
    nationalCode = json['nationalCode'];
    birthCertificateNumber = json['birthCertificateNumber'];
    birthDate = json['birthDate'];
    birthCityId = json['birthCityId'];
    birthProvinceId = json['birthCityProvinceId'] ;
    birthCountryId= json['birthCityCountryId'] ;
    marriedStatusId = json['marriedStatusId'];
    residenceCityId = json['residenceCityId'];
    residenceProvinceId = json['residenceCityProvinceId'];
    residenceCountryId = json['residenceCityCountryId'];
    organizationUnitId = json['organizationUnitId'];
    role = json['role'];
    organizationUnit = json['organizationUnit'] != null ? OrganizationUnit.fromJson(json['organizationUnit']) : null;
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    imageOnChanged = json['imageOnChanged'];
    imageId = json['imageId'];
  }

  int? id;
  String? code;
  int? type;
  String? firstname;
  String? lastname;
  String? firstNamePersian;
  String? lastNamePersian;
  String? firstNameEnglish;
  String? lastNameEnglish;
  String? positionPersian;
  String? positionEnglish;
  String? titlePersian;
  String? titleEnglish;
  String? email;
  bool? sexType;
  String? mobileNumber;
  int? nationalityId;
  String? nationalCode;
  String? birthCertificateNumber;
  String? birthDate;
  int? birthCityId;
  int? birthProvinceId;
  int? birthCountryId;
  int? marriedStatusId;
  int? residenceCityId;
  int? residenceProvinceId;
  int? residenceCountryId;
  int? organizationUnitId;
  int? role;
  OrganizationUnit? organizationUnit;
  Customer? customer;
  bool? imageOnChanged;
  ImageModel? image;
  int? imageId;
  int? jobTitleId;

  Map<String, dynamic> toJsonForUpdate() {
    final map = <String, dynamic>{};
    map['firstName'] = firstname;
    map['lastName'] = lastname;
    map['type'] = type;
    map['firstNamePersian'] = firstNamePersian;
    map['lastNamePersian'] = lastNamePersian;
    map['firstNameEnglish'] = firstNameEnglish;
    map['lastNameEnglish'] = lastNameEnglish;
    map['positionPersian'] = positionPersian;
    map['positionEnglish'] = positionEnglish;
    map['email'] = email;
    map['sexType'] = sexType;
    map['mobileNumber'] = mobileNumber;
    map['nationalityId'] = nationalityId;
    map['nationalCode'] = nationalCode;
    map['birthCertificateNumber'] = birthCertificateNumber;
    map['birthDate'] = birthDate;
    map['birthCityId'] = birthCityId;
    map['marriedStatusId'] = marriedStatusId;
    map['residenceCityId'] = residenceCityId;
    map['imageOnChanged'] = imageOnChanged;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstname;
    map['lastName'] = lastname;
    map['type'] = type;
    map['code'] = code;
    map['firstNamePersian'] = firstNamePersian;
    map['lastNamePersian'] = lastNamePersian;
    map['firstNameEnglish'] = firstNameEnglish;
    map['lastNameEnglish'] = lastNameEnglish;
    map['positionPersian'] = positionPersian;
    map['positionEnglish'] = positionEnglish;
    map['titlePersian'] = titlePersian;
    map['titleEnglish'] = titleEnglish;
    map['email'] = email;
    map['sexType'] = sexType;
    map['mobileNumber'] = mobileNumber;
    map['nationalityId'] = nationalityId;
    map['nationalCode'] = nationalCode;
    map['birthCertificateNumber'] = birthCertificateNumber;
    map['birthDate'] = birthDate;
    map['birthCityId'] = birthCityId;
    map['marriedStatusId'] = marriedStatusId;
    map['residenceCityId'] = residenceCityId;
    map['organizationUnitId'] = organizationUnitId;
    map['role'] = role;
    if (organizationUnit != null) {
      map['organizationUnit'] = organizationUnit?.toJson();
    }
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    return map;
  }

  Map<String, dynamic> employeeToJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['firstNamePersian'] = firstNamePersian;
    map['lastNamePersian'] = lastNamePersian;
    map['firstNameEnglish'] = firstNameEnglish;
    map['lastNameEnglish'] = lastNameEnglish;
    map['positionPersian'] = positionPersian;
    map['positionEnglish'] = positionEnglish;
    map['titlePersian'] = titlePersian;
    map['titleEnglish'] = titleEnglish;
    map['email'] = email;
    map['sexType'] = sexType;
    map['mobileNumber'] = mobileNumber;
    map['nationalityId'] = nationalityId;
    map['nationalCode'] = nationalCode;
    map['birthCertificateNumber'] = birthCertificateNumber;
    map['birthCityId'] = birthCityId;
    map['marriedStatusId'] = marriedStatusId;
    map['residenceCityId'] = residenceCityId;
    map['organizationUnitId'] = organizationUnitId;
    map['jobTitleId'] = jobTitleId;
    return map;
  }
}