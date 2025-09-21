import 'dart:convert';

import 'package:mailcow_app/env.dart';
import 'package:http/http.dart' as http;
import 'package:mailcow_app/models/mailcow_alias.dart';

Future updateAlias({required MailcowAlias alias}) async {
  await http.post(
    Uri.parse('https://vm1.fritz.box/api/v1/edit/alias'),
    headers: {
      "X-API-Key": MAILCOW_API_READ_WRITE,
      "accept": "application/json",
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "attr": {"address": alias.address, "goto": alias.goto},
      "items": [alias.id.toString()],
    }),
  );
}

Future deleteAlias({required MailcowAlias alias}) async {
  await http.post(
    Uri.parse('https://vm1.fritz.box/api/v1/delete/alias'),
    headers: {
      "X-API-Key": MAILCOW_API_READ_WRITE,
      "accept": "application/json",
      "Content-Type": "application/json",
    },
    body: jsonEncode([alias.id.toString()]),
  );
}
