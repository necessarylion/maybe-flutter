import 'package:flutter/material.dart';

import '../components/transaction_tile.dart';
import '../data/sample_transactions.dart';
import '../utils/colors.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = SampleTransactions.getTransactions();
    return Container(
      color: AppColors.background,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        itemCount: transactions.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'A summary of your latest activity',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          }
          final transaction = transactions[index - 1];
          return TransactionTile(transaction: transaction);
        },
      ),
    );
  }
}
