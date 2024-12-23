import 'package:flutter/material.dart';

class PaymentTile extends StatefulWidget {
  const PaymentTile(
      {super.key,
      required this.title,
      required this.hint,
      required this.isNumber,
      required this.controller,
      required this.formkey});
  final String title, hint;
  final bool? isNumber;
  final TextEditingController controller;
  final Key formkey;

  @override
  State<PaymentTile> createState() => _PaymentTileState();
}

class _PaymentTileState extends State<PaymentTile> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          widget.isNumber == null ? TextInputType.text : TextInputType.number,
      decoration:
          InputDecoration(label: Text(widget.title), hintText: widget.hint),
    );
  }
}
