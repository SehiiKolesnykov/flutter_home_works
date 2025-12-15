import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_tracker/models/transaction_model.dart';
import 'package:personal_finance_tracker/providers/settings_provider.dart';
import 'package:personal_finance_tracker/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TransactionsListScreen extends StatelessWidget {
  const TransactionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;
    final currency = Provider.of<SettingsProvider>(context).currency;

    return ListView.builder(
      padding: EdgeInsets.all(8.sp),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 4.sp),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: tx.type == TransactionType.income ? Colors.green : Colors.red,
              child: Icon(
                tx.type == TransactionType.income ? Icons.arrow_upward : Icons.arrow_downward,
                color: Colors.white,
              ),
            ),
            title: Text('${tx.amount.toStringAsFixed(2)} $currency'),
            subtitle: Text('${tx.description} - ${tx.category}\n${DateFormat('yyyy-MM-dd').format(tx.date)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              onPressed: () {
                Provider.of<TransactionProvider>(context, listen: false).deleteTransaction(tx);
              },
            ),
          ),
        );
      },
    );
  }
}