import 'package:flutter/material.dart';
import 'package:meta_wallet/level_1_core/util/event_bus.dart';
import 'package:meta_wallet/level_2_data/model/nft_model.dart';
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
  bool _isDark = true;

  void _changeMainTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  void initState() {
    super.initState();
    _news = newsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Navigation',
          onPressed: () => router.openPage(context, 'trace'),
        ),
        title: const Text("NFTs"),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isDark ? Icons.brightness_5 : Icons.brightness_4),
            tooltip: 'Theme',
            onPressed: () {
              eventBus.emit(gThemeChange);
              _changeMainTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_reaction_sharp),
            tooltip: 'Funny',
            onPressed: () => router.openPage(context, 'funny'),
          ),
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            tooltip: 'Transaction',
            onPressed: () => router.openPage(context, 'transaction'),
          ),
          IconButton(
            icon: const Icon(Icons.perm_identity),
            tooltip: 'Identity',
            onPressed: () => router.openPage(context, 'avatar'),
          )
        ],
      ),
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
