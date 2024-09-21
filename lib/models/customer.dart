import 'package:flutter/material.dart';

class Customer {
  final String id;
  final String name;
  final String contact;
  final String dlImage; // Ensure this field matches your data

  Customer({
    required this.id,
    required this.name,
    required this.contact,
    required this.dlImage,
  });

  // Create a Customer instance from a map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      contact: map['contact'] ?? '',
      dlImage: map['dlImage'] ?? 'assets/licence.jpeg', // Provide a default image path if needed
    );
  }

  // Convert a Customer instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'dlImage': dlImage,
    };
  }
}
