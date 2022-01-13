import 'package:flutter/material.dart';
import 'package:meta_wallet/level_3_business/nft/test_grid_list.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';

class GameLoad extends StatefulWidget {
  const GameLoad({Key? key}) : super(key: key);

  @override
  State<GameLoad> createState() => _GameLoadState();
}

class _GameLoadState extends State<GameLoad> {

  late final List _news;

  @override
  void initState() {
    super.initState();
    _news = newsList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 10, height: 200),
        TextButton(
          child: const Text("Let's Go!"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => Theme.of(context).buttonTheme.colorScheme!.background
            ),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) => Theme.of(context).buttonTheme.colorScheme!.primary
            ),
          ),
          onPressed: () => router.openPage(context, 'game_home')
        )
      ],
    );
  }
}
