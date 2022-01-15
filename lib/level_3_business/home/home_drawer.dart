import 'package:flutter/material.dart';
import 'package:meta_wallet/level_1_core/util/event_bus.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtain the theme mode.
    bool _isDark = Theme.of(context).brightness == Brightness.dark;
    //
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true, //移除抽屉菜单顶部默认留白
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.jpg',
                        width: 80,
                      ),
                    ),
                  ),
                  const Text(
                    "Aaron",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.perm_identity),
                    title: const Text('My profile'), // Identity
                    onTap: () => router.openPage(context, 'avatar'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: const Text('Transactions'),
                    onTap: () => router.openPage(context, 'transaction'),
                  ),
                  ListTile(
                    leading: Icon(_isDark ? Icons.brightness_5 : Icons.brightness_4),
                    title: Text(_isDark ? "Light Mode" : "Dark Mode"),
                    onTap: () => eventBus.emit(gThemeChange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}