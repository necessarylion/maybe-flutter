import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../utils/colors.dart';
import '../utils/currency_formatter.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.amount > 0;
    final isTransfer = transaction.type == TransactionType.transfer;
    final amountColor =
        isTransfer
            ? AppColors.textMuted
            : isIncome
            ? AppColors.positive
            : AppColors.negative;
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      leading: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.08),
        child: Icon(transaction.icon, color: AppColors.textPrimary),
      ),
      title: Text(
        transaction.description,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        transaction.accountName,
        style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${transaction.amount >= 0 ? '+' : '-'}${transaction.currency} ${CurrencyFormatter.formatCurrency(transaction.amount.abs())}',
            style: TextStyle(
              color: amountColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            DateFormat('d MMM yyyy').format(transaction.date),
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
