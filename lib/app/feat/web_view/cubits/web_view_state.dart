import 'package:webview_flutter/webview_flutter.dart';

class WebViewState {
  final WebViewController? webViewController;

  WebViewState({required this.webViewController});

  WebViewState copyWith({WebViewController? webViewController}) {
    return WebViewState(
        webViewController: webViewController ?? this.webViewController);
  }
}
