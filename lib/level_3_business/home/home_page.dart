import 'package:flutter/material.dart';
import 'package:meta_wallet/level_1_core/util/event_bus.dart';
import 'package:meta_wallet/level_2_data/model/nft_model.dart';
import 'package:meta_wallet/level_3_business/home/home_drawer.dart';
import 'package:meta_wallet/level_3_business/home/nft_grid_cell.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';
import 'package:meta_wallet/level_3_business/home/test_grid_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final List _news;

  @override
  void initState() {
    super.initState();
    _news = newsList;
  }

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.add_reaction_sharp),
            tooltip: 'Funny',
            onPressed: () => router.openPage(context, 'funny'),
          ),
          IconButton(
            icon: const Icon(Icons.query_stats),
            tooltip: 'Trace',
            onPressed: () => router.openPage(context, 'trace'),
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      body: GridView.builder(
        itemCount: _news.length,
        itemBuilder: (BuildContext context, int index) {
          NftModel model = NftModel(_news[index]);
          return NftGridCell(model);
        },
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75
        ),
      )
    );
  }
}
