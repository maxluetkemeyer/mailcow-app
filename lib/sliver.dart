import 'package:flutter/material.dart';
import 'package:mailcow_app/som_headline.dart';

class MySliver extends StatefulWidget {
  const MySliver({super.key});

  @override
  State<MySliver> createState() => _MySliverState();
}

class _MySliverState extends State<MySliver> {
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
              onPressed: () {},
              icon: const Icon(Icons.replay_outlined),
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
            return const ListTile(
              title: Text("Ebay"),
              subtitle: Text("name.generator@maxlu.cloud"),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 20,
        ),
        SliverToBoxAdapter(child: Container()),
        SliverList(
          delegate: SliverChildListDelegate([
            //FBimage(path: "ressorts/${widget.ressort.id}.png"),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "widget.ressort.description",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
