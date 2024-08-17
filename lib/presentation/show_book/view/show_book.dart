import 'dart:async';

import 'package:eqraa/core/app_export.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import '../../../core/functions/alert_alarm.dart';
import '../../booksScreen/controller/books_screen_controller.dart';
import '../../booksScreen/model/books_model.dart';
import '../controller/show_book_controller.dart';

class BookDetailScreen extends StatefulWidget {
  ///TODO: add all books here
  final Map<String, String> books = {
    'Alsera_Alnabawea': 'assets/pdf/Alsera_Alnabawea.pdf',
    'sera': 'assets/pdf/sera.pdf',
    'healthy book': 'assets/pdf/healthy book.pdf',
    'Doaa': 'assets/pdf/Doaa.pdf',
    'AllahIsTheRealLove': 'assets/pdf/AllahIsTheRealLove.pdf',
    'Arbaoon': 'assets/pdf/Arbaoon.pdf',
    'Ahlam': 'assets/pdf/Ahlam.pdf',
    'NLP': 'assets/pdf/NLP.pdf',
    'TheWizardAndTheStone': 'assets/pdf/TheWizardAndTheStone.pdf',
    'YouCantHurtMe': 'assets/pdf/YouCantHurtMe.pdf',
    'Shamail': 'assets/pdf/Shamail.pdf',
    'Leannak_Allah': 'assets/pdf/Leannak_Allah.pdf',
    'CookingBook': 'assets/pdf/CookingBook.pdf',
  };
  final int endTimeMillisecond;
  final Book book;
  BookDetailScreen({super.key,
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
  int highestPageReached = 0;
  TextEditingController noteController = TextEditingController();
  ShowBookControllerImp controller = Get.put(ShowBookControllerImp());

  @override
  void initState() {
    super.initState();
    startTimer();
    highestPageReached = controller.getLastSavedPage(widget.book.id!);

    fromAsset(widget.books[widget.book.title!].toString(), 'temp.pdf')
        .then((f) {
      setState(() {
        localPath = f.path;
        currentPage = highestPageReached; // Start from the highest page reached
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
    if (widget.endTimeMillisecond == -1) {
      return false;
    }
    int currentMillisecond = DateTime.now().millisecondsSinceEpoch;
    return (currentMillisecond >= widget.endTimeMillisecond);
  }

  final oneSec = const Duration(seconds: 1);
  late final Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if(_durationEnded()){
          setState(() {
            _timer.cancel();
            alertalarmApp();
          });
        }
      },
    );
  }


  @override
  void dispose() {
    saveHighestPageReached(); // Save the highest page before disposing the widget
    super.dispose();
  }

  void saveHighestPageReached() {
    // Call your controller to save the highest page reached

    controller.saveHighestPage(widget.book.id!, highestPageReached);
  }

  Widget _buildBody() {
    if (localPath != null) {
      return PDFView(
        defaultPage: currentPage,
        onRender: (pages) {
          setState(() {
            totalPages = pages!;
          });
        },
        onPageChanged: (int? page, int? total) {
          setState(() {
            currentPage = page!;
            if (currentPage > highestPageReached) {
              highestPageReached = currentPage; // Update highest page reached
            }
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
          title:  Text('178'.tr),
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
                  decoration:  InputDecoration(
                    hintText: '179 ...'.tr,
                    border:
                        OutlineInputBorder(), ////// تعديل شكل المربع تبع الملاحظات
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('180'.tr),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
            TextButton(
              child:  Text('33'.tr),
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
