import 'package:flutter/material.dart';
import 'package:meta_wallet/level_2_data/model/nft_model.dart';
import 'package:meta_wallet/level_3_business/funny/funny_cell.dart';
import 'package:meta_wallet/level_3_business/nft/test_grid_list.dart';

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
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                  "蛋世界",
                  style: Theme.of(context).textTheme.headline2
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
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                  "五谷世界",
                  style: Theme.of(context).textTheme.headline2
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
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                  "菜园的菜们",
                  style: Theme.of(context).textTheme.headline2
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
            ),
          ],
        ),
      ],
    );
  }
}
