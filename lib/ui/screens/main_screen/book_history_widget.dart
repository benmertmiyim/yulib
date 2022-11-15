import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yulib/core/model/book_model.dart';

class BookHistoryWidget extends StatelessWidget {
  final BookModel bookModel;

  const BookHistoryWidget({Key? key, required this.bookModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('yyyy-MM-dd hh:mm');
    var orderTime = DateTime.fromMillisecondsSinceEpoch(
        bookModel.orderTime!.millisecondsSinceEpoch);
    var deliveryTime = DateTime.fromMillisecondsSinceEpoch(
        bookModel.deliveryTime!.millisecondsSinceEpoch);
    Text delivery;
    if (orderTime != deliveryTime) {
      delivery = Text("Delivery Time: ${f.format(deliveryTime)}");
    } else {
      delivery = const Text("Delivery Time: --");
    }

    return Card(
        child: Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(flex:1,child: CachedNetworkImage(imageUrl: bookModel.imageURL)),
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
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                Text("Order Time: ${f.format(orderTime)}"),
                delivery,
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
