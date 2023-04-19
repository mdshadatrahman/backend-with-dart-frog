import 'dart:async';
import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';

// final connection = PostgreSQLConnection(
//   'localhost',
//   5432,
//   'apartmentinfo',
//   username: 'postgres',
//   password: 'root',
// );

final db = Database(
  host: 'localhost',
  port: 5432,
  database: 'apartmentinfo',
  user: 'postgres',
  password: 'root',
  useSSL: false,
);

Handler middleware(Handler handler) {
  return handler.use(provider<Database>((context) => db));
}
