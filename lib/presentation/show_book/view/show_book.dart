import 'dart:async';

import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/shared/custom_text_form_field.dart';
import 'package:eqraa/models/book_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/functions/alert_alarm.dart';
import '../../booksScreen/controller/books_screen_controller.dart';
import '../../booksScreen/model/books_model.dart';

class BookDetailScreen extends StatefulWidget {
  ///TODO: add all books here
  final Map<String, String> books = {
    'Alsera_Alnabawea': 'assets/pdf/Alsera_Alnabawea.pdf',
    'sera': 'assets/pdf/sera.pdf',
    'healthy book': 'assets/pdf/healthy book.pdf',
  };
  final int endTimeMillisecond;
  final Book book;
  BookDetailScreen({
    required this.book,
    this.endTimeMillisecond = -1,
  });

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  String? localPath;
  int totalPages = 0;
  int currentPage = 0;
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
    fromAsset(widget.books[widget.book.title!].toString(), 'temp.pdf')
        .then((f) {
      setState(() {
        localPath = f.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      throw Exception("Error copying asset to local storage: $e");
    }
  }

  bool _durationEnded() {
    if (widget.endTimeMillisecond == null || widget.endTimeMillisecond == -1) {
      return false;
    }
    int currentMillisecond = DateTime.now().millisecondsSinceEpoch;
    return (currentMillisecond >= widget.endTimeMillisecond);
  }

  final oneSec = const Duration(seconds: 1);
  late final Timer _timer;

  void startTimer() {
    if (widget.endTimeMillisecond == -1) {
      // No valid timer is set, do not start the timer
      return;
    }
    print("TIMER : ${widget.endTimeMillisecond}");
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_durationEnded()) {
          setState(() {
            _timer.cancel();
            alertalarmApp();
          });
        }
      },
    );
  }

  Widget _buildBody() {
    if (localPath != null) {
      return PDFView(
        onRender: (pages) {
          setState(() {
            totalPages = pages!;
          });
        },
        onPageChanged: (int? page, int? total) {
          setState(() {
            currentPage = page!;
          });
        },
        filePath: localPath,
        enableSwipe: true,
      );
    }

    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title!),
        leading: IconButton(
          icon: const Icon(
            Icons.add,
          ),
          onPressed: () {
            showMyDialog(context);
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ملاحظات'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('This is a simple dialog.'),
                // Text('Would you like to continue?'),
                TextField(
                  controller:
                      noteController, ///////  هذا بجبلي قيم النص وما شابه
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Allows the text field to expand as needed
                  decoration: const InputDecoration(
                    hintText: 'اكتب ...',
                    border:
                        OutlineInputBorder(), ////// تعديل شكل المربع تبع الملاحظات
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
            TextButton(
              child: const Text('حفظ'),
              onPressed: () async {
                BooksScreenControllerImp booksScreenController =
                    Get.put(BooksScreenControllerImp('null'));

                await booksScreenController.addBookMark(noteController.text,
                    widget.book.id!, currentPage, noteController.text);

                Navigator.of(context).pop();
                noteController.clear();
                // print(noteController.text);
                // print(currentPage);
                // print(widget.book.title!);
              },
            ),
          ],
        );
      },
    );
  }
}
