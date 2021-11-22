import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/transaction.dart';
import 'package:intl/intl.dart';

class ShowTransactionList extends StatelessWidget {
  final List<Transactions> transactionList;
  final Function removeTransaction;
  ShowTransactionList(this.transactionList, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).devicePixelRatio * 170,
        child: transactionList.length == 0
            ? Container(
                margin: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Image(image: AssetImage('assets/images/empty.png')),
                    Text(
                      "You didn't add any transaction yet!",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          transactionList[index].amount.toStringAsFixed(0),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        transactionList[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(transactionList[index].date)
                          .toString()),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red.shade300,
                          onPressed: () => removeTransaction(
                              transactionList[index]
                                  .id) // define delete functionality
                          ),
                    ),
                  );
                },
                itemCount: transactionList.length,
              ));
  }
}
