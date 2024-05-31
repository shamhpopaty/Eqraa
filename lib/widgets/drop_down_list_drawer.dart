import 'package:flutter/material.dart';

class DropDownList extends StatelessWidget {
  const DropDownList({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Container(
          width: 400,
          child: Text(
            "اللغة",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
          )),
      underline: Divider(
        color: Colors.white10,
        thickness: 2,
      ),
      isExpanded: true,
      items: [
        "Ar",
        "EN"
      ]
          .map((e) => DropdownMenuItem<String>(
        child: Text(e),
        value: e,
      ))
          .toList(),
      borderRadius: BorderRadius.circular(15), onChanged: (String? value) {  },
    );
  }
}
