import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InappWebViewScreen extends StatefulWidget {
  final String filePath;
  final String dirPath;

  const InappWebViewScreen({
    required this.filePath,
    required this.dirPath,
    super.key,
  });

  @override
  State<InappWebViewScreen> createState() => _InappWebViewScreenState();
}

class _InappWebViewScreenState extends State<InappWebViewScreen> {
  late final InAppWebViewGroupOptions options;
  InAppWebViewController? webViewController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowingReadAccessTo: Uri.parse("file://${widget.dirPath}"),
        allowsInlineMediaPlayback: true,
      ),
    );
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Icon(Icons.arrow_back),
              onPressed: () => webViewController?.goBack(),
            ),
            ElevatedButton(
              child: const Icon(Icons.arrow_forward),
              onPressed: () => webViewController?.goForward(),
            ),
            ElevatedButton(
              child: const Icon(Icons.refresh),
              onPressed: () => webViewController?.reload(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse('file://${widget.filePath}')),
              initialOptions: options,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                debugPrint('!!! onLoadStart(): url = $url');
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                debugPrint(
                    '!!! androidOnPermissionRequest(): resources = $resources');
                // return PermissionRequestResponse(
                //   resources: resources,
                //   action: PermissionRequestResponseAction.GRANT,
                // );
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                debugPrint(
                    '!!! shouldOverrideUrlLoading(): url = ${navigationAction.request.url}');
                var uri = navigationAction.request.url!;
                if (!["file"].contains(uri.scheme)) {
                  showToast('Переходы по внешним ссылкам запрещены');
                  return NavigationActionPolicy.CANCEL;
                }
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                debugPrint('!!! onLoadStop(): url = $url');
              },
              onLoadError: (controller, url, code, message) {
                debugPrint('!!! onLoadError(): message = $message');
              },
              onProgressChanged: (controller, progress) {
                debugPrint('!!! onProgressChanged(): progress = $progress');
                setState(() {
                  this.progress = progress / 100;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                debugPrint('!!! onUpdateVisitedHistory(): url = $url');
              },
              onConsoleMessage: (controller, consoleMessage) {
                debugPrint('!!! onConsoleMessage(): $consoleMessage');
              },
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
