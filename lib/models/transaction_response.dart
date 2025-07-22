class TransactionResponse {
  final List<Transaction> transactions;
  final Pagination pagination;

  TransactionResponse({required this.transactions, required this.pagination});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      transactions:
          (json['transactions'] as List)
              .map((transaction) => Transaction.fromJson(transaction))
              .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Transaction {
  final String id;
  final String date;
  final String amount;
  final String currency;
  final String name;
  final String? notes;
  final String classification;
  final TransactionAccount account;
  final String? category;
  final String? merchant;
  final List<String> tags;
  final Transfer? transfer;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.currency,
    required this.name,
    this.notes,
    required this.classification,
    required this.account,
    this.category,
    this.merchant,
    required this.tags,
    this.transfer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      amount: json['amount'] ?? '',
      currency: json['currency'] ?? '',
      name: json['name'] ?? '',
      notes: json['notes'],
      classification: json['classification'] ?? '',
      account: TransactionAccount.fromJson(json['account']),
      category: json['category'],
      merchant: json['merchant'],
      tags: List<String>.from(json['tags'] ?? []),
      transfer:
          json['transfer'] != null ? Transfer.fromJson(json['transfer']) : null,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  // Helper method to get numeric amount for calculations
  double get numericAmount {
    try {
      // Remove currency symbols and commas, then parse
      String cleanAmount = amount.replaceAll(RegExp(r'[^\d.-]'), '');
      return double.tryParse(cleanAmount) ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  // Helper method to get display amount (with currency symbol)
  String get displayAmount => amount;

  // Helper method to check if it's income or expense
  bool get isIncome => classification.toLowerCase() == 'income';
  bool get isExpense => classification.toLowerCase() == 'expense';
  bool get isTransfer => transfer != null;

  // Helper method to get formatted date
  DateTime get formattedDate {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return DateTime.now();
    }
  }
}

class TransactionAccount {
  final String id;
  final String name;
  final String accountType;

  TransactionAccount({
    required this.id,
    required this.name,
    required this.accountType,
  });

  factory TransactionAccount.fromJson(Map<String, dynamic> json) {
    return TransactionAccount(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      accountType: json['account_type'] ?? '',
    );
  }
}

class Transfer {
  final String id;
  final String amount;
  final String currency;
  final TransactionAccount otherAccount;

  Transfer({
    required this.id,
    required this.amount,
    required this.currency,
    required this.otherAccount,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      id: json['id'] ?? '',
      amount: json['amount'] ?? '',
      currency: json['currency'] ?? '',
      otherAccount: TransactionAccount.fromJson(json['other_account']),
    );
  }
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
