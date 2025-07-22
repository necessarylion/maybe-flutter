import 'package:flutter/material.dart';

class Account {
  final String name;
  final double balance;
  final String currency;
  final String type;
  final IconData icon;

  const Account({
    required this.name,
    required this.balance,
    required this.currency,
    required this.type,
    required this.icon,
  });
}
