import 'package:flutter/material.dart';

class OrderCompleted extends StatefulWidget {
  const OrderCompleted({Key? key}) : super(key: key);

  @override
  _OrderCompletedState createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  String dropdownValue = 'Dog';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:Padding(
      padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
      child: Column(
        children: [
          Container(
   child: DropdownButtonFormField(
          decoration: InputDecoration(
          enabledBorder: OutlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          ),
          dropdownColor: Colors.grey[200],
          value: dropdownValue,
          onChanged: (String? newValue) {
          setState(() {
          dropdownValue = newValue!;
          });
          },
          items: <String>['Dog', 'Cat', 'Tiger', 'Lion'].map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
          value: value,
          child: Text(
          value,
          style: TextStyle(fontSize: 20),
          ),
          );
          }).toList(),
          ),
          ),


        ],
      ),
    ),
    );
  }
}