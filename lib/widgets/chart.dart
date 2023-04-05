import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import './../models/transaction.dart';
import './chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTrx;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, ((index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTrx.length; i++) {
        if (recentTrx[i].date.day == weekDay.day &&
            recentTrx[i].date.month == weekDay.month &&
            recentTrx[i].date.year == weekDay.year) {
          totalSum += recentTrx[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).toString(),
        'amount': totalSum
      };
    })).reversed.toList();
  }

  Chart(this.recentTrx);

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'] as String, 
                e['amount'] as double,
                totalSpending == 0.0 ? 0.0 : (e['amount'] as double) / totalSpending
                ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
