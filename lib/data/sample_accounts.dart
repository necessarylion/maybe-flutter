import 'package:flutter/material.dart';

import '../models/account.dart';

class SampleAccounts {
  static List<Account> getAccounts() {
    return [
      const Account(
        name: 'Savings Account',
        balance: 5200.75,
        currency: 'THB',
        type: 'Savings',
        icon: Icons.savings,
      ),
      const Account(
        name: 'Checking Account',
        balance: 1340.20,
        currency: 'THB',
        type: 'Checking',
        icon: Icons.account_balance_wallet,
      ),
      const Account(
        name: 'Credit Card',
        balance: -250.50,
        currency: 'THB',
        type: 'Credit',
        icon: Icons.credit_card,
      ),
    ];
  }
}
