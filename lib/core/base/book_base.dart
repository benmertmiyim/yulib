import 'package:yulib/core/model/book_model.dart';
abstract class BookBase {
  Future<bool> orderBook(BookModel bookModel);
  Future<List<BookModel>?> getBooks();
  Future<BookModel?> getBook(String bookId);
  Future<List<BookModel>?> getOrders();
}
