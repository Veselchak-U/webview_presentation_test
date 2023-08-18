import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InappWebServerScreen extends StatefulWidget {
  final String filePath;

  const InappWebServerScreen(this.filePath, {super.key});

  @override
  State<InappWebServerScreen> createState() => _InappWebServerScreenState();
}

class _InappWebServerScreenState extends State<InappWebServerScreen> {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
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
