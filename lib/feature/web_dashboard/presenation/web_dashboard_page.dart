import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/presentation/widget/logout_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/app_bar_widget.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/dashed_line_painter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebDashboardPage extends StatefulWidget {
  final String url;
  final String token;
  final String cookie;

  const WebDashboardPage({
    super.key,
    required this.url,
    required this.token,
    required this.cookie,
  });

  @override
  State<WebDashboardPage> createState() => _WebDashboardPageState();
}

class _WebDashboardPageState extends State<WebDashboardPage> {
  WebViewController? controller;
  final WebViewCookieManager cookieManager = WebViewCookieManager();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initWebView();
  }

  Future<void> initWebView() async {
    try {
      /// Clear old cookies
      await cookieManager.clearCookies();

      /// Set ci_session cookie
      if (widget.cookie.isNotEmpty) {
        final cookieParts = widget.cookie.split('=');

        if (cookieParts.length >= 2) {
          await cookieManager.setCookie(
            WebViewCookie(
              name: cookieParts[0],
              value: cookieParts.sublist(1).join('='),
              domain: Uri.parse(widget.url).host,
              path: '/',
            ),
          );
        }
      }

      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                isLoading = false;
              });
            },
            onWebResourceError: (error) {
              debugPrint(error.description);
            },
          ),
        )
        ..loadRequest(
          Uri.parse(widget.url),
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        );
    } catch (e) {
      debugPrint("WebView Error: $e");
    }
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
                builder: (_) => const LogoutWidget(),
              );
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: controller == null || isLoading
          ? WaveLoaderWidget()
          : SafeArea(
              child: Stack(
                children: [
                  WebViewWidget(controller: controller!),
                ],
              ),
            ),
    );
  }
}
