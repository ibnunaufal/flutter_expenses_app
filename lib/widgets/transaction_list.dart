import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteFunc;

  TransactionList(this.transactions, this.deleteFunc);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Trx yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                            child: Text(
                                'Rp ${transactions[index].amount.toStringAsFixed(0)}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(icon: Icon(Icons.delete), color: Colors.red,onPressed: () => deleteFunc(transactions[index].id),),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
