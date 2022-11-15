import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulib/core/view/book_view.dart';
import 'package:yulib/ui/screens/main_screen/book_history_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<BookView>(context).getOrders(),
        builder: (ctx, bookView) {
          if (bookView.hasData) {
            if (bookView.data!.isEmpty) {
              return const Center(
                child: Text("You dont have any order"),
              );
            } else {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: bookView.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookHistoryWidget(bookModel: bookView.data![index]);
                  }
              );
            }
          } else {
            if (bookView.hasError) {
              return const Center(
                child: Text("You dont have any order"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        });
  }
}
