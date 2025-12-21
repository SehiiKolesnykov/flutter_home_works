import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personal_finance_tracker/providers/settings_provider.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final TextEditingController budgetController = TextEditingController(text: settings.monthlyBudget.toString());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Currency', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.sp),
            DropdownButton<String>(
              value: settings.currency,
              isExpanded: true,
              items: ['UAH', 'USD', 'EUR'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  settings.updateCurrency(newValue);
                }
              },
            ),
            SizedBox(height: 16.sp),
            Text('Monthly Budget Limit', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.sp),
            TextFormField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter budget limit',
              ),
              onChanged: (value) {
                double? newBudget = double.tryParse(value);
                if (newBudget != null) {
                  settings.updateMonthlyBudget(newBudget);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}