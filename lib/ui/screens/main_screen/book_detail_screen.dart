import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yulib/core/model/book_model.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel bookModel;

  const BookDetailScreen({Key? key, required this.bookModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookModel.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(aspectRatio: 16/9,child: CachedNetworkImage(imageUrl: bookModel.imageURL),),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookModel.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Category: ${bookModel.category}"),
                  Text("Language: ${bookModel.launguage}"),
                  Text("Writer: ${bookModel.writer}"),
                  Text("Location: ${bookModel.location}"),
                  const Text(
                    "About Book",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(bookModel.desc!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
