import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/widget/logout_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebDashboardPage extends StatefulWidget {
  final String url;
  final String name;
  final String token;

  const WebDashboardPage(
      {super.key, required this.url, required this.name, required this.token});

  @override
  State<WebDashboardPage> createState() => _WebDashboardPageState();
}

class _WebDashboardPageState extends State<WebDashboardPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    print("widget.url---  ${widget.url}");

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.url),
        headers: {
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Dashboard",
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const LogoutWidget(),
              );
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
