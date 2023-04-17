import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

final connection = PostgreSQLConnection(
  'localhost',
  5432,
  'apartmentinfo',
  username: 'postgres',
  password: 'root',
);

Handler middleware(Handler handler) {
  return handler.use(provider<PostgreSQLConnection>((context) => connection));
}
