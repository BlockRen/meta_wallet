import 'package:flutter/material.dart';
import 'package:meta_wallet/level_2_data/model/nft_model.dart';
import 'package:meta_wallet/level_3_business/funny/funny_cell.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';
import 'package:meta_wallet/level_3_business/home/test_grid_list.dart';

class FunnyPage extends StatefulWidget {
  const FunnyPage({Key? key}) : super(key: key);

  @override
  State<FunnyPage> createState() => _FunnyPageState();
}

class _FunnyPageState extends State<FunnyPage> {

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
        title: const Text("Funny"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            tooltip: 'Transaction',
            onPressed: () => router.openPage(context, 'transaction'),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 230,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: ListView.builder(
              itemCount: _news.length,
              itemBuilder: (BuildContext context, int index) {
                NftModel model = NftModel(_news[index]);
                return FunnyCell(model);
              },
              padding: const EdgeInsets.fromLTRB(12, 5, 5, 12),
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 230,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: ListView.builder(
              itemCount: _news.length,
              itemBuilder: (BuildContext context, int index) {
                NftModel model = NftModel(_news[index]);
                return FunnyCell(model);
              },
              padding: const EdgeInsets.fromLTRB(12, 5, 5, 12),
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      )
    );
  }
}
