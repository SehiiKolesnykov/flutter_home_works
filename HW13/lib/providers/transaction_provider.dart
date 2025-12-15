import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_finance_tracker/models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  late Box<Transaction> _transactionBox;
  List<Transaction> _transactions = [];

  TransactionProvider() {
    _transactionBox = Hive.box<Transaction>('transactions');
    _transactions = _transactionBox.values.toList();
    _transactionBox.listenable().addListener(_updateTransactions);
  }

  List<Transaction> get transactions => _transactions;

  void _updateTransactions() {
    _transactions = _transactionBox.values.toList();
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    _transactionBox.add(transaction);
  }

  void deleteTransaction(Transaction transaction) {
    transaction.delete();
  }

  @override
  void dispose() {
    _transactionBox.listenable().removeListener(_updateTransactions);
    super.dispose();
  }
}