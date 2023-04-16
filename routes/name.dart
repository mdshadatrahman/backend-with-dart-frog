import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final connection = context.read<PostgreSQLConnection>();
  await connection.open();

  final result = await connection.query('SELECT NOW();');

  return Response(body: 'Time now is: ${result[0][0]}');
}
