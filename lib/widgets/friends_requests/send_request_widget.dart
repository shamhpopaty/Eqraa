import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RequestComponent extends StatefulWidget {
  const RequestComponent({super.key});

  @override
  State<RequestComponent> createState() => _RequestComponentState();
}

class _RequestComponentState extends State<RequestComponent> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/𝑩𝒂𝒋𝒊✩.jpg'),
      ),
      title: Text('Haydy al meaaw'),
      trailing: MaterialButton(
        onPressed: () {},
        color: Colors.grey,
        child: Text('cancel'),
      ),
    );
  }
}