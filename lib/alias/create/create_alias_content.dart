import 'package:flutter/material.dart';
import 'package:mailcow_app/alias/create/action.dart';
import 'package:mailcow_app/models/mailcow_mailbox.dart';
import 'package:random_name_generator/random_name_generator.dart';

class CreateAliasContent extends StatefulWidget {
  final List<MailcowMailbox> mailboxes;

  const CreateAliasContent({
    super.key,
    required this.mailboxes,
  });

  @override
  State<CreateAliasContent> createState() => _CreateAliasContentState();
}

class _CreateAliasContentState extends State<CreateAliasContent> {
  final TextEditingController mailboxesController = TextEditingController();
  late final TextEditingController aliasController;

  MailcowMailbox? selectedMailbox;

  RandomNames randomNames = RandomNames(Zone.us);

  @override
  void initState() {
    super.initState();
    aliasController =
        TextEditingController(text: "${randomNames.name().toLowerCase()}.${randomNames.surname().toLowerCase()}");

    debugPrint("${randomNames.name().toLowerCase()}.${randomNames.surname().toLowerCase()}");
  }

  @override
  void dispose() {
    mailboxesController.dispose();
    aliasController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Alias"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: aliasController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Address', helperText: "@maxlu.cloud will be added"),
              ),
              const SizedBox(height: 16),
              DropdownMenu<MailcowMailbox>(
                initialSelection: widget.mailboxes.first,
                controller: mailboxesController,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                // On mobile platforms, this is false by default. Setting this to true will
                // trigger focus request on the text field and virtual keyboard will appear
                // afterward. On desktop platforms however, this defaults to true.
                requestFocusOnTap: true,
                label: const Text('Mailbox'),
                onSelected: (MailcowMailbox? mailbox) {
                  setState(() {
                    selectedMailbox = mailbox;
                  });
                },
                dropdownMenuEntries: widget.mailboxes.map<DropdownMenuEntry<MailcowMailbox>>((MailcowMailbox mailbox) {
                  return DropdownMenuEntry<MailcowMailbox>(
                    value: mailbox,
                    label: mailbox.username,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                  "When a mailbox is created, a user is allowed to send mail from and receive mail for his own mailbox address."),
              const Text("We can add aliases for a mailbox to receive mail for and to send from this new address."),
              const Text(
                  "It is important to know, that you are not able to receive mail for my-alias@my-alias-domain.tld. You would need to create this particular alias."),
              const SizedBox(height: 16),
              FilledButton(
                child: const Text("Create alias"),
                onPressed: () async {
                  String alias = "${aliasController.text}@maxlu.cloud";

                  await createAlias(address: alias, goto: mailboxesController.text);

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, alias);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
