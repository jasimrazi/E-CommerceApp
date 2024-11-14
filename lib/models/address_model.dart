class Address {
  final int? id; // Made nullable
  final int? user; // Made nullable
  final String name;
  final String country;
  final String city;
  final String phoneNumber;
  final String address;

  Address({
    this.id, // Optional for request
    this.user, // Optional for request
    required this.name,
    required this.country,
    required this.city,
    required this.phoneNumber,
    required this.address,
  });

  // Factory constructor to create an Address from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      user: json['user'],
      name: json['name'],
      country: json['country'],
      city: json['city'],
      phoneNumber: json['phone_number'],
      address: json['address'],
    );
  }

  // Convert an Address instance to JSON for requests
  Map<String, dynamic> toJson() {
    final data = {
      'name': name,
      'country': country,
      'city': city,
      'phone_number': phoneNumber,
      'address': address,
    };
    return data;
  }
}
