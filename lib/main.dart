import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import 'widgets/show_transaction_list.dart';
import './widgets/add_new_transaction.dart';
import 'widgets/chart_generate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ** loccks landscape orientation**

    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // **

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
    Transactions(id: "H1", title: "Watch", amount: 300, date: DateTime.now()),
    Transactions(id: "J1", title: "Watch", amount: 300, date: DateTime.now()),
    Transactions(id: "R1", title: "Watch", amount: 300, date: DateTime.now()),
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

  void _startAddingTransaction() {
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

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;
    final mediaQuery = MediaQuery.of(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text('Upto 136 recover'),
      actions: <Widget>[
        IconButton(
            onPressed: () => _startAddingTransaction(), icon: Icon(Icons.add))
      ],
    );

    final pageBody = isPortrait
        ? SafeArea(
            child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.25,
                    child: ChartGenerate(transactions)),
                // addig chart
                Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  child: ShowTransactionList(transactions, _removeTransaction),
                ), //adding the list
              ],
            ),
          ))
        // If not portrait**
        : SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Toggle to see transactions",
                      style: Platform.isIOS
                          ? TextStyle(
                              fontSize: 18,
                            )
                          : TextStyle(fontSize: 18),
                    ),
                    Switch.adaptive(
                        activeColor: Theme.of(context).primaryColor,
                        value: _showChart,
                        onChanged: (isOn) {
                          setState(() {
                            _showChart = isOn;
                          });
                        })
                  ],
                ),
                _showChart
                    ? Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.5,
                        child: ChartGenerate(transactions))
                    :
                    // addig chart
                    Container(
                        height: Platform.isIOS
                            ? (mediaQuery.size.height -
                                    appBar.preferredSize.height -
                                    mediaQuery.padding.top) *
                                0.85
                            : (mediaQuery.size.height -
                                    appBar.preferredSize.height -
                                    mediaQuery.padding.top) *
                                0.7,
                        child: ShowTransactionList(
                            transactions, _removeTransaction),
                      ), //adding the list
              ],
            ),
          );
    return isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.systemGrey5.withOpacity(0.3),
              middle: Text(
                "In IOS",
                style: TextStyle(color: (Colors.black)),
              ),
              trailing: CupertinoButton(
                child: Icon(Icons.add),
                onPressed: () => _startAddingTransaction(),
              ),
            ),
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.add,
              ),
              onPressed: () => _startAddingTransaction(),
            ),
          );
  }
}
