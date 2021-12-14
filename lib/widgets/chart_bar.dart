import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingAmount;
  final double spendingPcOfTotal; // Spending Persentage of Total

  ChartBar(
    this.lable,
    this.spendingAmount,
    this.spendingPcOfTotal,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
      return Column(
        children: [
          Container(
            height: constrains.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
              ),
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.05,
          ),
          Container(
            height: constrains.maxHeight * 0.6,
            width: 10.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPcOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.05,
          ),
          Container(
            height: constrains.maxHeight * 0.15,
            child: Text(lable),
          ),
        ],
      );
    });
  }
}
