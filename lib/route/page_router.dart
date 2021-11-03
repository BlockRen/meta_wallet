import 'package:flutter/material.dart';
import 'package:meta_wallet/ui/page/home_page.dart';
import 'package:meta_wallet/ui/page/transaction_page.dart';

class PageRouter {
  //私有构造函数
  PageRouter._internal();

  //保存单例
  static final PageRouter _singleton = PageRouter._internal();

  //工厂构造函数
  factory PageRouter()=> _singleton;

  //简单命名Route页面在此注册，则可以通过pushNamed方式的页面路由打开
  Map<String, WidgetBuilder> registerRoutes(BuildContext context) {
    return {
      "/":(context) => const HomePage(title: 'Meta Wallet'),
      "transaction":(context) => const TransactionPage(),
    };
  }

  // 是否是简单但命名Route
  bool isSimpleRouteName(String routeName) {
    bool isComplex = routeName.contains(RegExp(r'[:/?.-=]'));
    return !isComplex;
  }

  // cmd可以是page名称，带详细参数的url，或者正则式
  // 简单的名称路由，可以通过MaterialApp的routes属性注册
  // 此处为了支持复杂的路由方式
  void openPage(
    BuildContext context,
    String cmd, {
    Object? arguments,
  }) {
    // cmd是name
    if (isSimpleRouteName(cmd)) {
      Navigator.pushNamed(context, cmd, arguments: arguments);
      return;
    }
    // 复杂形式，如 meta://transaction?key=value
    // TODO
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        switch (cmd) {
          case "transaction": {
            return const TransactionPage();
          }
          break;
          default: {
            return const HomePage(title: "");
          }
        }
      }),
    );
  }

  // 关闭页面方法
  void closePage(BuildContext context, [result]) {
    Navigator.pop(context, [result]);
  }
}

//定义一个top-level（全局）变量，页面引入该文件后可以直接使用
var router = PageRouter();