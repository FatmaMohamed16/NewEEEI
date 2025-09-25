// import 'package:flutter/material.dart';

// class TypeModel {
//   final int id;
//   final String name;

//   List<FieldModel>? fields;

//   TypeModel({required this.id, required this.name, this.fields});

//   factory TypeModel.fromJson(Map<String, dynamic> json) {
//     return TypeModel(id: json['id'] as int, name: json['name'] as String);
//   }
// }

// class FieldModel {
//   final int id;
//   final String name;
//   final int typeId;
//   List<CompanyModel>? companies; // ✨ تأكد أن هذا السطر موجود ✨

//   FieldModel({
//     required this.id,
//     required this.name,
//     required this.typeId,
//     this.companies,
//   });

//   factory FieldModel.fromJson(Map<String, dynamic> json) {
//     return FieldModel(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       typeId: json['typeId'] as int,
//     );
//   }
// }

// class CompanyModel {
//   final int? id;
//   final int? fieldId;
//   final String? name;
//   final String? description;
//   final String? websiteUrl;
//   final String? email;
//   final String? phone;
//   final String? secondPhone;
//   final String? address;
//   final String? secondAddress;
//   final String? youtubeUrl;
//   final String? twitterUrl;
//   final String? tiktokUrl;
//   final String? linkedinUrl;
//   final String? facebookUrl;
//   final String? instagramUrl;
//   final String? logoImageUrl;

//   CompanyModel({
//     this.id,
//     this.fieldId,
//     this.name,
//     this.description,
//     this.websiteUrl,
//     this.email,
//     this.phone,
//     this.secondPhone,
//     this.address,
//     this.secondAddress,
//     this.youtubeUrl,
//     this.twitterUrl,
//     this.tiktokUrl,
//     this.linkedinUrl,
//     this.facebookUrl,
//     this.instagramUrl,
//     this.logoImageUrl,
//   });

//   factory CompanyModel.fromJson(Map<String, dynamic> json) {
//     return CompanyModel(
//       id: json['id'],
//       fieldId: json['fieldId'],
//       name: json['name'],
//       description: json['description'],
//       websiteUrl: json['websiteUrl'],
//       email: json['email'],
//       phone: json['phone'],
//       secondPhone: json['secondPhone'],
//       address: json['address'],
//       secondAddress: json['secondAddress'],
//       youtubeUrl: json['youtubeUrl'],
//       twitterUrl: json['twitterUrl'],
//       tiktokUrl: json['tiktokUrl'],
//       linkedinUrl: json['linkedinUrl'],
//       facebookUrl: json['facebookUrl'],
//       instagramUrl: json['instagramUrl'],
//       logoImageUrl: json['logoImageUrl'],
//     );
//   }
// }










//لو استخدمت الموديلات زي الداتابيز 


///////////////////
///
library;

import 'package:flutter/material.dart';

class TypeModel {
  final int id;
  final String name;

  List<FieldModel>? fields;

  TypeModel({required this.id, required this.name, this.fields});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class FieldModel {
  final int id;
  final String name;
  final int typeId;
  List<CompanyModel>? companies;

  FieldModel({
    required this.id,
    required this.name,
    required this.typeId,
    this.companies,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'] as int,
      name: json['name'] as String,
      typeId: json['typeId'] as int,
    );
  }
}
class CompanyModel {
  final int? id;
  final String? name;
  final String? description;
  final String? websiteUrl;
  final String? email;
  final String? phone;
  final String? secondPhone;
  final String? address;
  final String? secondAddress;
  final String? youtubeUrl;
  final String? twitterUrl;
  final String? tiktokUrl;
  final String? linkedinUrl;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? logoImageUrl;

  CompanyModel({
    this.id,
    this.name,
    this.description,
    this.websiteUrl,
    this.email,
    this.phone,
    this.secondPhone,
    this.address,
    this.secondAddress,
    this.youtubeUrl,
    this.twitterUrl,
    this.tiktokUrl,
    this.linkedinUrl,
    this.facebookUrl,
    this.instagramUrl,
    this.logoImageUrl,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      websiteUrl: json['websiteUrl'],
      email: json['email'],
      phone: json['phone'],
      secondPhone: json['secondPhone'],
      address: json['address'],
      secondAddress: json['secondAddress'],
      youtubeUrl: json['youtubeUrl'],
      twitterUrl: json['twitterUrl'],
      tiktokUrl: json['tiktokUrl'],
      linkedinUrl: json['linkedinUrl'],
      facebookUrl: json['facebookUrl'],
      instagramUrl: json['instagramUrl'],
      logoImageUrl: json['logoImageUrl'],
    );
  }
}




class CompanyFieldModel {
  final int companyId;
  final int fieldId;

  CompanyFieldModel({required this.companyId, required this.fieldId});

  factory CompanyFieldModel.fromJson(Map<String, dynamic> json) {
    return CompanyFieldModel(
      companyId: json['companyId'] as int,
      fieldId: json['fieldId'] as int,
    );
  }
}