import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;
  NewTransactions(this.addTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _onSubmitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Widget textFeildInput(String title, TextEditingController controller,
      TextInputType keyboardType) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          onSubmitted: (_) => _onSubmitData(),
          decoration: InputDecoration(
            labelText: title,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Container Which Contain TitleInput TextField
        textFeildInput('Title', _titleController, TextInputType.emailAddress),

        // Container Which Contain AmountInput TextField
        textFeildInput('Amount', _amountController, TextInputType.phone),

        // Row contain Text and TextButton to choose Date
        Container(
          height: 70.0,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    _selectedDate == null
                        ? 'No date choosen!'
                        : 'Picked Date:${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _presentDatePicker,
                child: Text(
                  'Choose Date!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // TextButton Which Submet TitleInput and AmountInput
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextButton(
                style: TextButton.styleFrom(),
                onPressed: _onSubmitData,
                child: Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
