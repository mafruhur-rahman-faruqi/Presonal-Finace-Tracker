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
    Transactions("G1", "Watch", 300, DateTime.now()),
    Transactions("G2", "Mouse", 1200, DateTime.now()),
  ];

  void addTransaction(newTitle, newAmount) {
    var justAdded = Transactions(DateTime.now().toString(), newTitle, newAmount,
        DateTime.now()..toString());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('110 Recover'),
        actions: <Widget>[
          IconButton(
              onPressed: () => startAddingTransaction(), icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ChartGenerate(transactions), // addig chart
            ShowTransactionList(transactions), //adding the list
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
