import 'package:app_architecture/users/models/address_model.dart';
import 'package:app_architecture/users/models/company_model.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final CompanyModel company;
  final AddressModel address;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.company,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      company: CompanyModel.fromJson(json['company']),
      address: AddressModel.fromJson(json['address']),
    );
  }
}
