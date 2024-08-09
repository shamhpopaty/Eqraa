import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/functions/alert_alarm.dart';

class BookListScreen extends StatelessWidget {
  final List<Book> books = [
    Book('Book 1', 'assets/pdf/doaa.pdf'),
    Book('Book 2', 'assets/pdf/sera.pdf'),
    Book('Book 3', 'assets/pdf/hart.pdf'),
  ];

  final int endTimeMillisecond;

  BookListScreen({super.key, this.endTimeMillisecond = -1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(
                    book: books[index],
                    endTimeMillisecond: endTimeMillisecond,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Book {
  final String title;
  final String assetPath;

  Book(this.title, this.assetPath);
}

class BookDetailScreen extends StatefulWidget {
  final Book book;
  final int endTimeMillisecond;

  BookDetailScreen({
    required this.book,
    this.endTimeMillisecond = -1,
  });

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    startTimer();
    fromAsset(widget.book.assetPath, 'temp.pdf').then((f) {
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

  Widget _buildBody() {
    if (localPath != null) {
      return PDFView(
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
        title: Text(widget.book.title),
      ),
      body: _buildBody(),
    );
  }
}
