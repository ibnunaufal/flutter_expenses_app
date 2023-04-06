import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expenses_app/widgets/new_transaction.dart';
import 'package:flutter_expenses_app/widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() { 
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Balrow'),
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
    // Transactions(
    //     id: '1', title: "Sepatu baru", amount: 100000, date: DateTime.now()),
    // Transactions(
    //     id: '2', title: "Kaos baru", amount: 100000, date: DateTime.now()),
  ];

  List<Transactions> get _recentTrx {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime dateTime) {
    print("_addNewTransaction called");
    final newTrx = Transactions(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: dateTime);

    setState(() {
      _userTransaction.add(newTrx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _startAddNewTrx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Flutter Expenses App'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTrx(context), icon: Icon(Icons.add))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTrx)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height) *
                    0.7,
                child: TransactionList(_userTransaction, _deleteTransaction))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTrx(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
