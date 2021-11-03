import 'package:flutter/material.dart';
import 'package:meta_wallet/ui/theme/light_theme.dart';
import 'package:meta_wallet/ui/theme/dart_theme.dart';
import 'package:meta_wallet/util/event_bus.dart';
import 'package:meta_wallet/route/page_router.dart';

void main() {
  runApp(const MetaApp());
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
    bus.on(bThemeChange, _changeTheme);
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
    bus.off(bThemeChange, _changeTheme);
    super.dispose();
  }
}
