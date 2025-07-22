import 'package:flutter/material.dart';

import '../models/transaction.dart';

class SampleTransactions {
  static List<Transaction> getTransactions() {
    return [
      Transaction(
        description: 'Salary',
        amount: 5000.00,
        currency: 'THB',
        date: DateTime.now().subtract(const Duration(days: 1)),
        accountName: 'Checking Account',
        type: TransactionType.income,
        icon: Icons.attach_money,
      ),
      Transaction(
        description: 'Coffee Shop',
        amount: -120.00,
        currency: 'THB',
        date: DateTime.now().subtract(const Duration(days: 1)),
        accountName: 'Checking Account',
        type: TransactionType.expense,
        icon: Icons.local_cafe,
      ),
      Transaction(
        description: 'Groceries',
        amount: -800.00,
        currency: 'THB',
        date: DateTime.now().subtract(const Duration(days: 2)),
        accountName: 'Savings Account',
        type: TransactionType.expense,
        icon: Icons.shopping_cart,
      ),
      Transaction(
        description: 'Credit Card Payment',
        amount: -250.50,
        currency: 'THB',
        date: DateTime.now().subtract(const Duration(days: 3)),
        accountName: 'Credit Card',
        type: TransactionType.transfer,
        icon: Icons.credit_card,
      ),
      Transaction(
        description: 'Flight Ticket',
        amount: -3200.00,
        currency: 'THB',
        date: DateTime.now().subtract(const Duration(days: 4)),
        accountName: 'Travel Fund',
        type: TransactionType.expense,
        icon: Icons.flight_takeoff,
      ),
      Transaction(
        description: 'Stock Dividend',
        amount: 400.00,
        currency: 'THB',
        date: DateTime.now().subtract(const Duration(days: 5)),
        accountName: 'Investment Portfolio',
        type: TransactionType.income,
        icon: Icons.trending_up,
      ),
      Transaction(
        description: 'Restaurant',
        amount: -650.00,
        currency: 'THB',
        date: DateTime.now().subtract(const Duration(days: 6)),
        accountName: 'Checking Account',
        type: TransactionType.expense,
        icon: Icons.restaurant,
      ),
      Transaction(
        description: 'Transfer to Savings',
        amount: -1000.00,
        currency: 'THB',
        date: DateTime.now().subtract(const Duration(days: 7)),
        accountName: 'Checking Account',
        type: TransactionType.transfer,
        icon: Icons.swap_horiz,
      ),
    ];
  }
}
