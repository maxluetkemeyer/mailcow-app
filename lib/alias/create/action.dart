import 'dart:convert';

import 'package:mailcow_app/env.dart';
import 'package:http/http.dart' as http;

Future createAlias({required String address, required String goto}) async {
  await http.post(
    Uri.parse('https://vm1.fritz.box/api/v1/add/alias'),
    headers: {
      "X-API-Key": MAILCOW_API_READ_WRITE,
      "accept": "application/json",
      "Content-Type": "application/json",
    },
    body: jsonEncode({"active": 1, "address": address, "goto": goto}),
  );
}
