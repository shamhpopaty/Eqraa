import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Alarm Time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Time: ${selectedTime.hour}:${selectedTime.minute}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showDateTimePicker();
              },
              child: Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDateTimePicker() {
    // DatePicker.showTimePicker(
    //   context,
    //   showTitleActions: true,
    //   onChanged: (time) {
    //     print('change $time');
    //   },
    //   onConfirm: (time) {
    //     setState(() {
    //       selectedTime = time;
    //     });
    //   },
    //   currentTime: DateTime.now(),
    //   locale: LocaleType.en,
    // );
  }
}