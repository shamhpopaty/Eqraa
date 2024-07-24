import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RecievedComponent extends StatefulWidget {
  const RecievedComponent({super.key});

  @override
  State<RecievedComponent> createState() => _RecievedComponentState();
}

class _RecievedComponentState extends State<RecievedComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/𝑩𝒂𝒋𝒊✩.jpg'),
          ),
          Spacer(flex: 1,),
          Text('meaw al meaw'),
          Spacer(flex: 2,),
          Column(
            children: [
              MaterialButton(
                onPressed: () {},
                color: Colors.green,
                child: Text('Accept',style: TextStyle(color: Colors.white),),
              ),
              SizedBox(
                height: 8,
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.red,
                child: Text('Refuse',style: TextStyle(color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
    // return ListTile(
    //   contentPadding: EdgeInsets.all(20),
    //   leading: CircleAvatar(
    //     backgroundImage: AssetImage('assets/𝑩𝒂𝒋𝒊✩.jpg'),
    //   ),
    //   title: Text('Haydy al meaaw'),
    //   trailing: Column(
    //     children: [
    //       MaterialButton(
    //         onPressed: () {},
    //         color: Colors.green,
    //         child: Text('Accept'),
    //       ),
    //        MaterialButton(
    //         onPressed: () {},
    //         color: Colors.red,
    //         child: Text('Refuse'),
    //       ),
    //     ],
    //   ),
    // );
  }
}