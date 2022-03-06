import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  /// Connect the generated [_$AddressModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

//final String street;
}
