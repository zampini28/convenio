import 'dart:convert';

List<SubService> subServiceFromJson(String str) =>
    List<SubService>.from(json.decode(str).map((x) => SubService.fromJson(x)));

String subServiceToJson(List<SubService> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubService {
  SubService({
    required this.id,
    required this.serviceCenterName,
    required this.serviceCenterAddress,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.email,
    required this.ownername,
    required this.status,
    required this.createBy,
    required this.createAt,
    required this.serviceType,
    required this.serviceTypeName,
    required this.serviceTags,
    required this.queryFlag,
  });

  String id;
  String serviceCenterName;
  String serviceCenterAddress;
  String latitude;
  String longitude;
  String phone;
  String email;
  String ownername;
  dynamic status;
  dynamic createBy;
  dynamic createAt;
  String serviceType;
  String serviceTypeName;
  String serviceTags;
  dynamic queryFlag;

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
    id: json['Id'],
    serviceCenterName: json['ServiceCenterName'],
    serviceCenterAddress: json['ServiceCenterAddress'],
    latitude: json['Latitude'],
    longitude: json['Longitude'],
    phone: json['Phone'],
    email: json['Email'],
    ownername: json['Ownername'],
    status: json['Status'],
    createBy: json['CreateBy'],
    createAt: json['CreateAt'],
    serviceType: json['ServiceType'],
    serviceTypeName: json['ServiceTypeName'],
    serviceTags: json['ServiceTags'],
    queryFlag: json['QueryFlag'],
  );

  Map<String, dynamic> toJson() => {
    'Id': id,
    'ServiceCenterName': serviceCenterName,
    'ServiceCenterAddress': serviceCenterAddress,
    'Latitude': latitude,
    'Longitude': longitude,
    'Phone': phone,
    'Email': email,
    'Ownername': ownername,
    'Status': status,
    'CreateBy': createBy,
    'CreateAt': createAt,
    'ServiceType': serviceType,
    'ServiceTypeName': serviceTypeName,
    'ServiceTags': serviceTags,
    'QueryFlag': queryFlag,
  };
}
