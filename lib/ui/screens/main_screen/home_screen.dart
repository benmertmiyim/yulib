import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulib/core/view/book_view.dart';
import 'package:yulib/ui/screens/main_screen/book_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<BookView>(context).getBooks(),
        builder: (ctx, bookView) {
          if (bookView.hasData) {
            if (bookView.data!.isEmpty) {
              return const Center(
                child: Text("there is no book available"),
              );
            } else {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: bookView.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookWidget(bookModel: bookView.data![index]);
                  }
              );
            }
          } else {
            if (bookView.hasError) {
              return const Center(
                child: Text("there is no book available"),
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
