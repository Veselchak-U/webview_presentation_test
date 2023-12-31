import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:presentation_test/features/presentation_view/screens/webview_screen/widgets/pdf_view_dialog.dart';

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

  final List<String> _eventLog = [];
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
    _addLogEvent('presentation_open', widget.filePath);
  }

  @override
  void dispose() {
    _addLogEvent('presentation_close', widget.filePath);
    super.dispose();
  }

  void _addLogEvent(String event, String message) {
    final shortMessage = message.replaceAll(widget.dirPath, '');
    final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    _eventLog.add(
        '$dateTime, PRESENTATION: $_currentPresentation, SLIDE: $_currentSlide, EVENT: $event, MESSAGE: $shortMessage');
  }

  Future<void> _viewLog() async {
    _openTextViewDialog(_eventLog);
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
      body: Row(
        children: [
          Container(
            color: Theme.of(context).colorScheme.inversePrimary,
            child: SafeArea(
              child: Column(
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(24),
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
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
                  ElevatedButton(
                    onPressed: _viewLog,
                    child: const Text('Лог'),
                  ),
                  const Spacer(),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.file(widget.filePath)),
                  initialOptions: options,
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                    _addJavaScriptHandlers(controller);
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    debugPrint(
                        '!!! shouldOverrideUrlLoading() url = ${navigationAction.request.url}');
                    var uri = navigationAction.request.url!;
                    if (!["file"].contains(uri.scheme)) {
                      showToast('Переходы по внешним ссылкам запрещены');
                      return NavigationActionPolicy.CANCEL;
                    }
                    if (uri.path.contains(widget.dirPath)) {
                      if (uri.path.toLowerCase().endsWith('.pdf')) {
                        _openPdfViewDialog(uri.path);
                        return NavigationActionPolicy.CANCEL;
                      }
                      return NavigationActionPolicy.ALLOW;
                    } else {
                      final fullUri = _getFullFileUri(uri);
                      controller.loadUrl(
                        urlRequest: URLRequest(url: fullUri),
                      );
                      return NavigationActionPolicy.CANCEL;
                    }
                  },
                  onUpdateVisitedHistory: (controller, uri, androidIsReload) {
                    debugPrint('!!! onUpdateVisitedHistory() url = $uri');
                    _addLogEvent('go_to_url', uri?.path ?? '');
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  onLoadStop: (controller, url) async {
                    debugPrint('!!! onLoadStop() url = $url');
                    _executeJavaScripts(controller);
                  },
                  onLoadError: (controller, url, code, message) {
                    debugPrint('!!! onLoadError() message = $message');
                    _addLogEvent('page_load_error', message);
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    debugPrint(
                        '!!! onConsoleMessage() message = ${consoleMessage.message}');
                    // _addLogEvent('js_console_message', consoleMessage.message);
                  },
                ),
                progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
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

  bool _pdfViewDialogOpened = false;

  Future<void> _openPdfViewDialog(String filePath) async {
    if (_pdfViewDialogOpened) {
      return;
    }
    _addLogEvent('open_pdf', filePath);
    _pdfViewDialogOpened = true;
    await showDialog(
      context: context,
      builder: (context) => PdfViewDialog(filePath),
    );
    _pdfViewDialogOpened = false;
    _addLogEvent('close_pdf', filePath);
  }

  Future<void> _openTextViewDialog(List<String> text) async {
    await showDialog(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                text.length,
                (index) => Text(text[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addJavaScriptHandlers(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
      handlerName: _getVariablesHandlerName,
      callback: _getVariablesHandlerCallback,
    );
    controller.addJavaScriptHandler(
      handlerName: _sendBtnHandlerName,
      callback: _sendBtnHandlerCallback,
    );
  }

  Future<void> _executeJavaScripts(InAppWebViewController controller) async {
    controller.evaluateJavascript(
      source: _getVariablesJsSource,
    );
    controller.evaluateJavascript(
      source: _sendBtnJsSource,
    );
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
    debugPrint('!!! _getVariablesHandlerCallback() args = $args');
    if (args.isNotEmpty) {
      final variables = args[0];
      _currentPresentation = variables['CURRENT_PRESENTATION'];
      _currentSlide = variables['CURRENT_SLIDE'];
    }
  }

  final _sendBtnHandlerName = 'sendBtnHandler';

  String get _sendBtnJsSource => """
    const btns = document.querySelectorAll('.send_btn');
    console.log(btns.length);
    Array.from(btns).forEach((btn) => {
      console.log(btn);
      btn.addEventListener('click', (e) => {
        const data = sessionStorage.getItem('metricsProfile');
        window.flutter_inappwebview.callHandler('$_sendBtnHandlerName', data)
        return;
      });
    });
    """;

  dynamic _sendBtnHandlerCallback(List<dynamic> args) {
    debugPrint('!!! _sendBtnHandlerCallback() args = $args');
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
