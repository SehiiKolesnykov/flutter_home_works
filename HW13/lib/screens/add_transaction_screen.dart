import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_tracker/models/transaction_model.dart';
import 'package:personal_finance_tracker/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  double _amount = 0.0;
  String _description = '';
  String _category = 'Food';
  DateTime _date = DateTime.now();
  TransactionType _type = TransactionType.expense;

  final List<String> _categories = ['Food', 'Transport', 'Entertainment', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter an amount';
                    if (double.tryParse(value) == null) return 'Invalid amount';
                    return null;
                  },
                  onSaved: (value) => _amount = double.parse(value!),
                ),
                SizedBox(height: 16.sp),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter a description';
                    return null;
                  },
                  onSaved: (value) => _description = value!,
                ),
                SizedBox(height: 16.sp),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: _categories.map((String cat) {
                    return DropdownMenuItem<String>(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: (newValue) => setState(() => _category = newValue!),
                ),
                SizedBox(height: 16.sp),
                ListTile(
                  title: Text('Date: ${DateFormat('yyyy-MM-dd').format(_date)}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) setState(() => _date = selectedDate);
                  },
                ),
                SizedBox(height: 16.sp),
                DropdownButtonFormField<TransactionType>(
                  initialValue: _type,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: TransactionType.values.map((TransactionType type) {
                    return DropdownMenuItem<TransactionType>(
                      value: type,
                      child: Text(type.toString().split('.').last.capitalize()),
                    );
                  }).toList(),
                  onChanged: (newValue) => setState(() => _type = newValue!),
                ),
                SizedBox(height: 24.sp),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final transaction = Transaction(
                        amount: _amount,
                        description: _description,
                        category: _category,
                        date: _date,
                        type: _type,
                      );
                      Provider.of<TransactionProvider>(context, listen: false).addTransaction(transaction);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Transaction'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}