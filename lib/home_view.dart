import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailcow_app/home_content.dart';
import 'package:mailcow_app/models/mailcow_alias.dart';
import 'package:mailcow_app/env.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(
        Uri.parse('https://10.100.0.1/api/v1/get/alias/all'),
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

        List<MailcowAlias> aliases = [];
        for (dynamic data in dataList) {
          MailcowAlias alias = MailcowAlias.fromJson(data as Map<String, dynamic>);
          aliases.add(alias);
        }

        return HomeContent(
          aliases: aliases,
        );
      },
    );
  }
}
