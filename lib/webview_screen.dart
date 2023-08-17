import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String filePath;

  const WebViewScreen(this.filePath, {super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView.onProgress($progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('WebView.onPageStarted: $url');
          },
          onPageFinished: (String url) {
            debugPrint('WebView.onPageFinished: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView.onWebResourceError: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('WebView.onNavigationRequest: ${request.url}');
            if (request.url.startsWith('http')) {
              debugPrint(
                  'WebView._navigationDelegate() external launch URL: ${request.url}');
              showToast('Переходы по внешним ссылкам запрещены');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          showToast('Message from JavaScript: ${message.message}');
        },
      )
      ..loadFile(widget.filePath);
    // ..loadRequest(Uri.parse('file:/${widget.filePath}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: _controller),
    );
  }
}
