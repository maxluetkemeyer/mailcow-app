import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailcow_app/alias/alias_content.dart';
import 'package:mailcow_app/env.dart';
import 'package:mailcow_app/models/mailcow_alias.dart';
import 'package:mailcow_app/models/mailcow_mailbox.dart';

class AliasView extends StatelessWidget {
  final MailcowAlias alias;

  const AliasView({super.key, required this.alias});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(
        Uri.parse('https://vm1.fritz.box/api/v1/get/mailbox/all/'),
        headers: {
          "X-API-Key": MAILCOW_API_READ_WRITE,
          "accept": "application/json",
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        List<dynamic> dataList = jsonDecode(snapshot.data!.body);

        List<MailcowMailbox> mailboxes = [];

        for (dynamic data in dataList) {
          MailcowMailbox mailbox = MailcowMailbox.fromJson(
            data as Map<String, dynamic>,
          );
          mailboxes.add(mailbox);
        }

        return AliasContent(mailboxes: mailboxes, alias: alias);
      },
    );
  }
}
