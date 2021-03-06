import 'dart:math';

import 'package:app_despesas/components/transaction_form.dart';
import 'package:app_despesas/components/transaction_list.dart';
import 'package:app_despesas/models/transaction.dart';
import 'package:flutter/material.dart';


main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.red,
      ),
      );
  }
}

class MyHomePage extends StatefulWidget {
 
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
  

class _MyHomePageState extends State<MyHomePage> {


  final List<Transaction> _transactions = [
  ]; 

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return false;
    }).toList();
  }

  _addTransaction(String title, double value){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
  
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();

  }

   _openTransactionFormModal(BuildContext context){
   showModalBottomSheet(
     context: context, 
     builder: (_){
      return TransactionForm(_addTransaction);
     });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais')
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                color: Colors.blueAccent,
                child: Text('Grafico'),
                elevation: 6,
              )
            ),
            TransactionList(_transactions)
        ],
      ),
   ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}