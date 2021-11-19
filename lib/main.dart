import 'package:flutter/material.dart';
import 'package:meta_wallet/level_1_core/util/event_bus.dart';
import 'package:meta_wallet/level_2_ui//theme/light_theme.dart';
import 'package:meta_wallet/level_2_ui/theme/dart_theme.dart';
import 'package:meta_wallet/level_2_ui/model/account_model.dart';
import 'package:meta_wallet/level_3_business/route/page_router.dart';

void main() {
  runApp(const MetaApp());
  // 账户初始化
  AccountModel().update();
}

class MetaApp extends StatefulWidget {
  const MetaApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MetaAppState();
}

class _MetaAppState extends State<MetaApp> {

  late bool isDark;

  void _changeTheme(dynamic arg) {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  void initState() {
    super.initState();
    isDark = false;
    eventBus.on(gThemeChange, _changeTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wa Meta',
      theme: isDark ? darkTheme : lightTheme,
      routes: router.registerRoutes(context),
    );
  }

  @override
  void dispose() {
    eventBus.off(gThemeChange, _changeTheme);
    super.dispose();
  }
}
