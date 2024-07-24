
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BookListScreen extends StatelessWidget {
  final List<Book> books = [
    Book('Book 1', 'assets/pdf/doaa.pdf'),
    Book('Book 2', 'assets/pdf/sera.pdf'),
    Book('Book 3', 'assets/pdf/hart.pdf'),
  ];

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
                  builder: (context) => BookDetailScreen(book: books[index]),
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

  BookDetailScreen({required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: localPath != null
          ? PDFView(
        filePath: localPath,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}