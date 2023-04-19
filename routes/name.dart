import 'dart:async';
import 'dart:indexed_db';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  // final connection = context.read<PostgreSQLConnection>();
  // final result = await connection.query('SELECT NOW();');

  final db = context.read<Database>();

  return Response(body: 'Time now is:');
}
