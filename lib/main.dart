import 'package:flutter/material.dart';
import './models/transaction.dart';
import 'widgets/show_transaction_list.dart';
import './widgets/add_new_transaction.dart';
import 'widgets/chart_generate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green, accentColor: Colors.cyan),
      ),
      title: '110 Recovery',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> transactions = [
    Transactions(id: "G1", title: "Watch", amount: 300, date: DateTime.now()),
  ];

  void addTransaction(newTitle, newAmount, txDate) {
    var justAdded = Transactions(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: txDate);

    setState(() {
      transactions.add(justAdded);
    });
  }

  void startAddingTransaction() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(30),
            child: AddNewTransaction(addTransaction),
          );
        });
  }

  void _removeTransaction(String deleteId) {
    setState(() {
      transactions.removeWhere((tx) {
        return tx.id == deleteId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('Upto 136 recover'),
        actions: <Widget>[
          IconButton(
              onPressed: () => startAddingTransaction(), icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ChartGenerate(transactions), // addig chart
            ShowTransactionList(
                transactions, _removeTransaction), //adding the list
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.add,
        ),
        onPressed: () => startAddingTransaction(),
      ),
    );
  }
}
