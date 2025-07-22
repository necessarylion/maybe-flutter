class AccountResponse {
  final List<Account> accounts;
  final Pagination pagination;

  AccountResponse({required this.accounts, required this.pagination});

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return AccountResponse(
      accounts:
          (json['accounts'] as List)
              .map((account) => Account.fromJson(account))
              .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Account {
  final String id;
  final String name;
  final String balance;
  final String currency;
  final String classification;
  final String accountType;

  Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.currency,
    required this.classification,
    required this.accountType,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      balance: json['balance'] ?? '',
      currency: json['currency'] ?? '',
      classification: json['classification'] ?? '',
      accountType: json['account_type'] ?? '',
    );
  }

  // Helper method to get numeric balance for calculations
  double get numericBalance {
    try {
      // Remove currency symbols and commas, then parse
      String cleanBalance = balance.replaceAll(RegExp(r'[^\d.-]'), '');
      return double.tryParse(cleanBalance) ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  // Helper method to get display balance (with currency symbol)
  String get displayBalance => balance;
}

class Pagination {
  final int page;
  final int perPage;
  final int totalCount;
  final int totalPages;

  Pagination({
    required this.page,
    required this.perPage,
    required this.totalCount,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] ?? 1,
      perPage: json['per_page'] ?? 100,
      totalCount: json['total_count'] ?? 0,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}
