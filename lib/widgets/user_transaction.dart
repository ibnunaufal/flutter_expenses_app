import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import './../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transactions> _userTransaction = [
    Transactions(
        id: '1', title: "Sepatu baru", amount: 100000, date: DateTime.now()),
    Transactions(
        id: '2', title: "Kaos baru", amount: 100000, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount){
    print("_addNewTransaction called");
    final newTrx = Transactions(id: DateTime.now().toString(), title: title, amount: amount, date: DateTime.now());
    
    setState(() {
      _userTransaction.add(newTrx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NewTransaction(_addNewTransaction),
      TransactionList(_userTransaction)
    ],);
  }
}