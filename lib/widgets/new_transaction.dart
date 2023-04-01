import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewTransaction extends StatelessWidget {
  final Function addTrx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTrx);

  void _submitData(){
    if (titleController.text.isEmpty || double.parse(amountController.text) <= 0) {
      return;
    }
    addTrx(titleController.text, double.parse(amountController.text));
  }
  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    onSubmitted: ((value) => _submitData),
                  ),
                  ElevatedButton(onPressed: () {                    
                    _submitData();                    
                  }, child: Text('Tambahkan'))
                ],
              ),
            ),
          );
  }
}