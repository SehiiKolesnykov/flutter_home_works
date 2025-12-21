import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/models/transaction_model.dart';
import 'package:personal_finance_tracker/providers/settings_provider.dart';
import 'package:personal_finance_tracker/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  Map<String, double> _calculateCategoryExpenses(List<Transaction> transactions) {
    final Map<String, double> categoryExpenses = {};
    for (var tx in transactions.where((tx) => tx.type == TransactionType.expense)) {
      categoryExpenses.update(tx.category, (value) => value + tx.amount, ifAbsent: () => tx.amount);
    }
    return categoryExpenses;
  }

  double _calculateMonthlyTotal(List<Transaction> transactions, TransactionType type, DateTime month) {
    return transactions
        .where((tx) => tx.type == type && tx.date.year == month.year && tx.date.month == month.month)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;
    final currency = Provider.of<SettingsProvider>(context).currency;
    final budget = Provider.of<SettingsProvider>(context).monthlyBudget;
    final now = DateTime.now();
    final monthlyExpenses = _calculateMonthlyTotal(transactions, TransactionType.expense, now);
    final monthlyIncome = _calculateMonthlyTotal(transactions, TransactionType.income, now);
    final categoryExpenses = _calculateCategoryExpenses(transactions);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Monthly Summary', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.sp),
                    Text('Income: ${monthlyIncome.toStringAsFixed(2)} $currency'),
                    Text('Expenses: ${monthlyExpenses.toStringAsFixed(2)} $currency'),
                    Text('Budget Limit: ${budget.toStringAsFixed(2)} $currency'),
                    Text('Remaining: ${(budget - monthlyExpenses).toStringAsFixed(2)} $currency',
                        style: TextStyle(color: (budget - monthlyExpenses) >= 0 ? Colors.green : Colors.red)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.sp),
            Text('Top Expense Categories', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.sp),
            ...categoryExpenses.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                trailing: Text('${entry.value.toStringAsFixed(2)} $currency'),
              );
            }),
          ],
        ),
      ),
    );
  }
}