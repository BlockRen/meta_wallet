import 'package:flutter/material.dart';
import 'package:meta_wallet/level_2_data/model/nft_model.dart';
import 'package:meta_wallet/level_3_business/nft/nft_grid_cell.dart';
import 'package:meta_wallet/level_3_business/nft/test_grid_list.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';

class NftPage extends StatefulWidget {
  const NftPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> {
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
        title: const Text("NFTs"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            tooltip: 'Transaction',
            onPressed: () => router.openPage(context, 'transaction'),
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
            childAspectRatio: 0.75),
      )
    );
  }
}
