import 'dart:convert';

class ShippingAddressModel {
  final String id;
  final String name;
  final String userFullName;
  final String country;
  final String state;
  final String city;
  final String street;

  ShippingAddressModel({
    required this.id,
    required this.name,
    required this.userFullName,
    required this.country,
    required this.state,
    required this.city,
    required this.street,
  });

  ShippingAddressModel copyWith({
    String? id,
    String? name,
    String? userFullName,
    String? country,
    String? state,
    String? city,
    String? street,
  }) {
    return ShippingAddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userFullName: userFullName ?? this.userFullName,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      street: street ?? this.street,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userFullName': userFullName,
      'country': country,
      'state': state,
      'city': city,
      'street': street,
    };
  }

  factory ShippingAddressModel.fromMap(Map<String, dynamic> map) {
    return ShippingAddressModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      userFullName: map['userFullName'] ?? '',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      street: map['street'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingAddressModel.fromJson(String source) =>
      ShippingAddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShippingAddressModel(id: $id, name: $name, userFullName: $userFullName, country: $country, state: $state, city: $city, street: $street)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShippingAddressModel &&
        other.id == id &&
        other.name == name &&
        other.userFullName == userFullName &&
        other.country == country &&
        other.state == state &&
        other.city == city &&
        other.street == street;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        userFullName.hashCode ^
        country.hashCode ^
        state.hashCode ^
        city.hashCode ^
        street.hashCode;
  }
}
