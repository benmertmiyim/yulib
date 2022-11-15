import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yulib/core/model/book_model.dart';
import 'package:yulib/ui/screens/main_screen/book_detail_screen.dart';

class BookWidget extends StatelessWidget {
  final BookModel bookModel;

  const BookWidget({Key? key, required this.bookModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BookDetailScreen(
              bookModel: bookModel,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: CachedNetworkImage(imageUrl: bookModel.imageURL)),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 3,
              child: Column(
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
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
