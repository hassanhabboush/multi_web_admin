import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/ProductScreen';

  Widget _rowHeder(String text,int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700),
          color: Colors.yellow.shade900,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Product',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              _rowHeder('IMAGE', 1),
              _rowHeder('FULL NAME', 3),
              _rowHeder('PRICE', 2),
              _rowHeder('QUANTITY', 2),
              _rowHeder('ACTION', 1),
              _rowHeder('VIEW MORE', 1),

            ],
          ),
        ],
      ),
    );
  }
}
