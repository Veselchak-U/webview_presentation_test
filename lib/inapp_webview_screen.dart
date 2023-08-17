import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InappWebViewScreen extends StatefulWidget {
  final String filePath;

  const InappWebViewScreen(this.filePath, {super.key});

  @override
  State<InappWebViewScreen> createState() => _InappWebViewScreenState();
}

class _InappWebViewScreenState extends State<InappWebViewScreen> {
  final localhostServer = InAppLocalhostServer();
  late InAppWebViewController webView;
  bool serverStarted = false;

  @override
  void initState() {
    super.initState();
    _initServer();
  }

  Future<void> _initServer() async {
    await localhostServer.start();
    Future.delayed(
      Duration.zero,
      () => setState(() {
        serverStarted = true;
      }),
    );
  }

  @override
  void dispose() {
    localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: serverStarted
          ? InAppWebView(
              initialFile: widget.filePath,
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
