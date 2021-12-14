import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/modles/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> resentTransaction;

  Chart(this.resentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      // For loop to get totalSum of resentTransaction of the right date
      var totalSum = 0.0;
      for (var i = 0; i < resentTransaction.length; i++) {
        // ignore: unrelated_type_equality_checks
        if (resentTransaction[i].date.day == weekDay &&
            resentTransaction[i].date.month == weekDay.month &&
            resentTransaction[i].date.year == weekDay.year) {
          totalSum += resentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Expanded(
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
