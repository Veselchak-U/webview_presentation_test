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

  String? _currentPresentation;
  String? _currentSlide;

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
        allowingReadAccessTo: Uri.file(widget.dirPath),
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
              initialUrlRequest: URLRequest(url: Uri.file(widget.filePath)),
              initialOptions: options,
              onWebViewCreated: (controller) {
                webViewController = controller;
                controller.addJavaScriptHandler(
                  handlerName: _getVariablesHandlerName,
                  callback: _getVariablesHandlerCallback,
                );
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                debugPrint(
                    '!!! shouldOverrideUrlLoading() url = ${navigationAction.request.url}');
                var uri = navigationAction.request.url!;
                if (!["file"].contains(uri.scheme)) {
                  showToast('Переходы по внешним ссылкам запрещены');
                  return NavigationActionPolicy.CANCEL;
                }

                if (uri.path.contains(widget.dirPath)) {
                  return NavigationActionPolicy.ALLOW;
                } else {
                  final fullUri = _getFullFileUri(uri);
                  controller.loadUrl(
                    urlRequest: URLRequest(url: fullUri),
                  );
                  return NavigationActionPolicy.CANCEL;
                }
              },
              onProgressChanged: (controller, progress) {
                debugPrint('!!! onProgressChanged() progress = $progress');
                setState(() {
                  this.progress = progress / 100;
                });
              },
              onLoadStop: (controller, url) async {
                debugPrint('!!! onLoadStop() url = $url');
                await controller.evaluateJavascript(
                  source: _getVariablesJsSource,
                );
              },
              onLoadError: (controller, url, code, message) {
                debugPrint(
                    '!!! onLoadError() code = $code, message = $message');
              },
              onConsoleMessage: (controller, consoleMessage) {
                debugPrint('!!! onConsoleMessage(): ${consoleMessage.message}');
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

  Uri _getFullFileUri(Uri uri) {
    var fullPath = '${widget.dirPath}${uri.path}';
    if (uri.hasQuery) {
      fullPath += '?${uri.query}';
    }
    if (uri.hasFragment) {
      fullPath += '#${uri.fragment}';
    }
    return Uri.parse('file://$fullPath');
  }

  final _getVariablesHandlerName = 'getVariablesHandler';

  String get _getVariablesJsSource => """
      args = [{
          'CURRENT_PRESENTATION': CURRENT_PRESENTATION,
          'CURRENT_SLIDE': CURRENT_SLIDE,
      }];
      window.flutter_inappwebview.callHandler('$_getVariablesHandlerName', ...args);
    """;

  dynamic _getVariablesHandlerCallback(List<dynamic> args) {
    if (args.isNotEmpty) {
      final variables = args[0];
      _currentPresentation = variables['CURRENT_PRESENTATION'];
      _currentSlide = variables['CURRENT_SLIDE'];
    }
    debugPrint('!!! _getVariablesHandlerCallback() args = $args');
  }

// final _summHandlerName = 'summHandler';
//
// dynamic _summHandlerCallback(List<dynamic> args) {
//   debugPrint('!!! _summHandlerCallback() args = $args');
//   num result = 0;
//   for (final element in args) {
//     if (element is num) {
//       result += element;
//     }
//   }
//   debugPrint('!!! _summHandlerCallback() result = $result');
//   return result;
// }
//
// String get _summHandlerJsSource => """
//   window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
//     console.log('!!! flutterInAppWebViewPlatformReady');
//     const args = [300, 30, 3];
//     window.flutter_inappwebview.callHandler('$_summHandlerName', ...args)
//       .then(function(result) {
//         console.log(result);
//       });
//     });
//   """;
}
