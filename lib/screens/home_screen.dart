import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import 'accounts_screen.dart';
import 'transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: null,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset(
            'assets/logomark-color.svg',
            height: 32,
            width: 32,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/32.jpg',
              ),
              backgroundColor: AppColors.avatarBackground,
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        centerTitle: true,
        elevation: 2,
      ),
      body:
          _selectedIndex == 0
              ? const AccountsScreen()
              : const TransactionsScreen(),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.bottomNavBackground,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left tab - Accounts
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color:
                            _selectedIndex == 0
                                ? AppColors.addButtonBackground
                                : AppColors.unselectedNav,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Accounts',
                        style: TextStyle(
                          color:
                              _selectedIndex == 0
                                  ? AppColors.addButtonBackground
                                  : AppColors.unselectedNav,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Center button - Add Transaction
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.addButtonBackground,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: RawMaterialButton(
                onPressed: () {
                  // TODO: Add new transaction
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Add Transaction functionality coming soon!',
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                shape: const CircleBorder(),
                elevation: 0,
                fillColor: Colors.transparent,
                constraints: const BoxConstraints.tightFor(
                  width: 60,
                  height: 60,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.textPrimary,
                  size: 28,
                ),
              ),
            ),
            // Right tab - Transactions
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swap_horiz,
                        color:
                            _selectedIndex == 1
                                ? AppColors.addButtonBackground
                                : AppColors.unselectedNav,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Transactions',
                        style: TextStyle(
                          color:
                              _selectedIndex == 1
                                  ? AppColors.addButtonBackground
                                  : AppColors.unselectedNav,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
