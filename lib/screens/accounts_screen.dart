import 'package:flutter/material.dart';

import '../components/account_card.dart';
import '../components/welcome_header.dart';
import '../models/account_response.dart';
import '../services/accounts_service.dart';
import '../utils/colors.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  List<Account> accounts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await AccountsService.getAccounts();

      if (result['success']) {
        final accountResponse = result['data'] as AccountResponse;
        setState(() {
          accounts = accountResponse.accounts;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred while loading accounts';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.addButtonBackground,
                  ),
                ),
              )
              : _errorMessage != null
              ? _buildErrorWidget()
              : _buildAccountsList(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.textSecondary,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadAccounts,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.addButtonBackground,
              foregroundColor: AppColors.textPrimary,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      itemCount: accounts.length + 2, // +1 for header, +1 for create button
      itemBuilder: (context, index) {
        if (index == 0) {
          return const WelcomeHeader();
        }
        if (index == accounts.length + 1) {
          // Create account button at the bottom
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Navigate to create account screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Create Account functionality coming soon!'),
                    backgroundColor: AppColors.addButtonBackground,
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.addButtonBackground,
                side: const BorderSide(color: AppColors.addButtonBackground),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
              ),
              icon: const Icon(Icons.add_circle_outline, size: 20),
              label: const Text(
                'Create an account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          );
        }
        final account = accounts[index - 1];
        return AccountCard(
          account: account,
          onTap: () {
            // TODO: Navigate to account details
          },
        );
      },
    );
  }
}
