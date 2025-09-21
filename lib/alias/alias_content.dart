import 'package:flutter/material.dart';
import 'package:mailcow_app/alias/actions.dart';
import 'package:mailcow_app/models/mailcow_alias.dart';
import 'package:mailcow_app/models/mailcow_mailbox.dart';

class AliasContent extends StatefulWidget {
  final List<MailcowMailbox> mailboxes;
  final MailcowAlias alias;

  const AliasContent({super.key, required this.mailboxes, required this.alias});

  @override
  State<AliasContent> createState() => _AliasContentState();
}

class _AliasContentState extends State<AliasContent> {
  final TextEditingController mailboxesController = TextEditingController();
  late final TextEditingController aliasController;

  MailcowMailbox? selectedMailbox;

  @override
  void initState() {
    super.initState();
    aliasController = TextEditingController(text: widget.alias.address);
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
      appBar: AppBar(title: const Text("Edit Alias")),
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
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
              ),
              const SizedBox(height: 16),
              DropdownMenu<MailcowMailbox>(
                initialSelection: widget.mailboxes
                    .where(
                      (MailcowMailbox mailbox) =>
                          mailbox.username == widget.alias.goto,
                    )
                    .first,
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
                dropdownMenuEntries: widget.mailboxes
                    .map<DropdownMenuEntry<MailcowMailbox>>((
                      MailcowMailbox mailbox,
                    ) {
                      return DropdownMenuEntry<MailcowMailbox>(
                        value: mailbox,
                        label: mailbox.username,
                      );
                    })
                    .toList(),
              ),
              const SizedBox(height: 16),
              FilledButton(
                child: const Text("Update alias"),
                onPressed: () async {
                  await updateAlias(
                    alias: MailcowAlias(
                      address: aliasController.text,
                      domain: widget.alias.domain,
                      goto: mailboxesController.text,
                      id: widget.alias.id,
                    ),
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  await deleteAlias(alias: widget.alias);

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text("Delete alias"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
