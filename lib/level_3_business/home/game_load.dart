import 'package:flutter/foundation.dart';
import 'package:meta_wallet/level_1_core/network/http_request.dart';
import 'package:flutter/material.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';

class GameLoad extends StatefulWidget {
  const GameLoad({Key? key}) : super(key: key);

  @override
  State<GameLoad> createState() => _GameLoadState();
}

class _GameLoadState extends State<GameLoad> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(!kIsWeb) {
      HttpRequest().downloadFile("http://www.aaronview.cn/design/res/character.riv", "character",
        onProgress: (double progress) {
          debugPrint("Download Progress: " + progress.toString());
      });
    }

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
