import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/modles/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constrains) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: constrains.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waitingToAddTask.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    onTap: () {},

                    // The Left Side of ListTile Which Contain The Price
                    leading: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Text(
                        '\$${transactions[index].amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),

                    // The Meddile of ListTile Which Contain The Main Title
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),

                    // The Meddile of ListTile Which Contain The Sub Title (Time)
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),

                    // The Left side of ListTile which contain deleteButton to delete Transaction
                    // If the width of listTile is more than 360 we use TextButton(Icon + Text)
                    // If the width of ListTile is less than 360 we use IconButton (Delet Icon only)
                    trailing: MediaQuery.of(context).size.width > 360
                        ? TextButton.icon(
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            label: Text(
                              'Delete',
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                            ),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
