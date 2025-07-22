import 'package:flutter/material.dart';

class Transaction {
  final String description;
  final double amount;
  final String currency;
  final DateTime date;
  final String accountName;
  final TransactionType type;
  final IconData icon;

  const Transaction({
    required this.description,
    required this.amount,
    required this.currency,
    required this.date,
    required this.accountName,
    required this.type,
    required this.icon,
  });
}

enum TransactionType { income, expense, transfer }
