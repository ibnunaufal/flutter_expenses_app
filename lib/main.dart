import 'package:flutter/material.dart';
import 'package:flutter_expenses_app/widgets/new_transaction.dart';
import 'package:flutter_expenses_app/widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Balrow'
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void _startAddNewTrx(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (bCtx){
      return GestureDetector(
        onTap: (){},
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_addNewTransaction));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expenses App'),
        actions: [
          IconButton(onPressed: () => _startAddNewTrx(context), icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.blue,
              child: Container(width: double.infinity, child: Text('Chart')),
              elevation: 5,
            ),
            TransactionList(_userTransaction)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _startAddNewTrx(context), child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
