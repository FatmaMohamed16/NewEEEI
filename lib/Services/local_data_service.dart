// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:eeei/models.dart';

// class LocalDataService {
//   static Future<List<CompanyModel>> loadCompanies() async {
//     final String response = await rootBundle.loadString('assets/data/companies.json');
//     final List<dynamic> data = json.decode(response);
//     return data.map((json) => CompanyModel.fromJson(json)).toList();
//   }

//   static Future<List<TypeModel>> loadTypes() async {
//     final String response = await rootBundle.loadString('assets/data/types.json');
//     final List<dynamic> data = json.decode(response);
//     return data.map((json) => TypeModel.fromJson(json)).toList();
//   }

//   static Future<List<FieldModel>> loadFields() async {
//     final String response = await rootBundle.loadString('assets/data/fields.json');
//     final List<dynamic> data = json.decode(response);
//     return data.map((json) => FieldModel.fromJson(json)).toList();
//   }
// }













// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:eeei/models.dart';

// class LocalDataService {
//   static Future<List<TypeModel>> loadAllData() async {
//     final String typesResponse = await rootBundle.loadString('assets/data/types.json');
//     final List<dynamic> typesData = json.decode(typesResponse);
//     final List<TypeModel> types = typesData.map((json) => TypeModel.fromJson(json)).toList();

//     final String fieldsResponse = await rootBundle.loadString('assets/data/fields.json');
//     final List<dynamic> fieldsData = json.decode(fieldsResponse);
//     final List<FieldModel> fields = fieldsData.map((json) => FieldModel.fromJson(json)).toList();

//     final String companiesResponse = await rootBundle.loadString('assets/data/companies.json');
//     final List<dynamic> companiesData = json.decode(companiesResponse);
//     final List<CompanyModel> companies = companiesData.map((json) => CompanyModel.fromJson(json)).toList();

//     // ربط الشركات بالمجالات
//     for (var field in fields) {
//       field.companies = companies.where((company) => company.fieldId == field.id).toList();
//     }

//     // ربط المجالات بالأنواع
//     for (var type in types) {
//       type.fields = fields.where((field) => field.typeId == type.id).toList();
//     }

//     return types;
//   }
// }
















//لو استخدمت العلاقات زي الداتابيز 
///
///
library;

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:eeei/models.dart';
class LocalDataService {
  static Future<List<TypeModel>> loadAllData() async {
    try {
      final String typesResponse = await rootBundle.loadString('assets/data/types.json');
      final String fieldsResponse = await rootBundle.loadString('assets/data/fields.json');
      final String companiesResponse = await rootBundle.loadString('assets/data/companies_normalized.json');
      final String companyFieldsResponse = await rootBundle.loadString('assets/data/company_fields.json');
      final List<dynamic> typesData = json.decode(typesResponse);
      final List<dynamic> fieldsData = json.decode(fieldsResponse);
      final List<dynamic> companiesData = json.decode(companiesResponse);
      final List<dynamic> companyFieldsData = json.decode(companyFieldsResponse);
      final List<TypeModel> types = typesData.map((json) => TypeModel.fromJson(json)).toList();
      final List<FieldModel> fields = fieldsData.map((json) => FieldModel.fromJson(json)).toList();
      final List<CompanyModel> companies = companiesData.map((json) => CompanyModel.fromJson(json)).toList();
      final List<CompanyFieldModel> companyFields = companyFieldsData.map((json) => CompanyFieldModel.fromJson(json)).toList();
      final Map<int, CompanyModel> companyMap = {
        for (var company in companies) company.id!: company
      };
      final Map<int, List<CompanyModel>> fieldCompaniesMap = {};
      for (var cf in companyFields) {
        if (companyMap.containsKey(cf.companyId)) {
          fieldCompaniesMap.putIfAbsent(cf.fieldId, () => []).add(companyMap[cf.companyId]!);
        }
      }
      for (var type in types) {
        type.fields = fields
            .where((field) => field.typeId == type.id)
            .toList();
        for (var field in type.fields!) {
          field.companies = fieldCompaniesMap[field.id] ?? [];
        }
      }
      return types;
    } on Exception catch (e) {
      print("Error loading data in LocalDataService: $e");
      rethrow;
    }
  }
}