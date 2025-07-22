import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_response.dart';
import '../utils/colors.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({super.key, required this.transaction});

  // Generate a consistent icon based on transaction name and type
  IconData _getTransactionIcon() {
    final icons = [
      Icons.account_balance,
      Icons.account_balance_wallet,
      Icons.credit_card,
      Icons.savings,
      Icons.account_circle,
      Icons.business,
      Icons.home,
      Icons.school,
      Icons.work,
      Icons.favorite,
      Icons.star,
      Icons.diamond,
      Icons.flight,
      Icons.car_rental,
      Icons.hotel,
      Icons.restaurant,
      Icons.shopping_cart,
      Icons.local_grocery_store,
      Icons.local_mall,
      Icons.local_pharmacy,
      Icons.attach_money,
      Icons.money_off,
      Icons.trending_up,
      Icons.trending_down,
      Icons.swap_horiz,
      Icons.compare_arrows,
      Icons.payment,
      Icons.receipt,
      Icons.receipt_long,
      Icons.account_box,
      Icons.account_tree,
      Icons.assessment,
      Icons.analytics,
      Icons.bar_chart,
      Icons.pie_chart,
      Icons.show_chart,
      Icons.timeline,
      Icons.track_changes,
      Icons.insert_chart,
    ];

    // Use transaction name and type to generate consistent icon
    final hash = (transaction.name + transaction.classification).hashCode;
    final index = hash.abs() % icons.length;
    return icons[index];
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.isIncome;
    final isTransfer = transaction.isTransfer;
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
        child: Icon(
          _getTransactionIcon(),
          color: AppColors.textPrimary,
          size: 20,
        ),
      ),
      title: Text(
        transaction.name,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction.account.name,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
          if (transaction.isTransfer && transaction.transfer != null)
            Text(
              '${isIncome ? 'From' : 'To'} ${transaction.transfer!.otherAccount.name}',
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            transaction.displayAmount,
            style: TextStyle(
              color: amountColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            DateFormat('d MMM yyyy').format(transaction.formattedDate),
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
