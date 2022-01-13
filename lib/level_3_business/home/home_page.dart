import 'package:flutter/material.dart';
import 'package:meta_wallet/level_1_core/network/http_request.dart';
import 'package:meta_wallet/level_3_business/home/game_load.dart';
import 'package:meta_wallet/level_3_business/home/home_drawer.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    HttpRequest().downloadFile("http://www.aaronview.cn/design/res/character.riv", "character",
      onProgress: (double progress) {
        debugPrint("Download Progress: " + progress.toString());
    });

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   tooltip: 'Menu',
        //   onPressed: () => Scaffold.of(context).openDrawer(),
        // ),
        title: const Text("Meta Planet"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_reaction),
            tooltip: 'Funny',
            onPressed: () => router.openPage(context, 'funny'),
          ),
          IconButton(
            icon: const Icon(Icons.add_reaction_sharp),
            tooltip: 'Nft',
            onPressed: () => router.openPage(context, 'nft'),
          ),
          IconButton(
            icon: const Icon(Icons.query_stats),
            tooltip: 'Trace',
            onPressed: () => router.openPage(context, 'trace'),
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      body: const GameLoad(),
    );
  }
}
