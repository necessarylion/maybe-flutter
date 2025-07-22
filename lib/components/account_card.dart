import 'package:flutter/material.dart';

import '../models/account_response.dart';
import '../utils/colors.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback? onTap;

  const AccountCard({super.key, required this.account, this.onTap});

  // Generate a consistent icon based on account name
  IconData _getAccountIcon() {
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
    ];

    // Use account name to generate consistent icon
    final hash = account.name.hashCode;
    final index = hash.abs() % icons.length;
    return icons[index];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
      color: AppColors.cardBackground,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.08),
          child: Icon(
            _getAccountIcon(),
            color: AppColors.textPrimary,
            size: 20,
          ),
        ),
        title: Text(
          account.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          account.accountType.toUpperCase(),
          style: const TextStyle(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              account.displayBalance,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              account.currency,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
