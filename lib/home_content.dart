import 'package:flutter/material.dart';
import 'package:mailcow_app/alias/alias_view.dart';
import 'package:mailcow_app/app.dart';
import 'package:mailcow_app/models/mailcow_alias.dart';
import 'package:mailcow_app/som_headline.dart';

class HomeContent extends StatefulWidget {
  final List<MailcowAlias> aliases;

  const HomeContent({super.key, required this.aliases});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          expandedHeight: 140,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
              icon: const Icon(Icons.replay_outlined),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const App()),
                  (route) => false,
                );
              },
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(0),
            expandedTitleScale: 1.1,
            title: Padding(
              padding: const EdgeInsets.all(12),
              child: SomHeadline(
                lineWidth: 240,
                color: Theme.of(context).colorScheme.inversePrimary,
                child: const Text(
                  "Mailcow App",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList.separated(
          itemBuilder: (context, index) {
            MailcowAlias alias = widget.aliases[index];

            return ListTile(
              title: Text(alias.address),
              subtitle: Text(alias.goto),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AliasView(alias: alias),
                  ),
                ).then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const App()),
                    (route) => false,
                  );
                });
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: widget.aliases.length,
        ),
      ],
    );
  }
}

/*SliverToBoxAdapter(
          child: Container(),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              //FBimage(path: "ressorts/${widget.ressort.id}.png"),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "widget.ressort.description",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),*/
