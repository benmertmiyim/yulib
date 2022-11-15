import 'package:get_it/get_it.dart';
import 'package:yulib/core/service/auth_service.dart';
import 'package:yulib/core/service/book_service.dart';
import 'package:yulib/core/view/auth_view.dart';
import 'package:yulib/core/view/book_view.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthView());
  locator.registerLazySingleton(() => BookService());
  locator.registerLazySingleton(() => BookView());
}
