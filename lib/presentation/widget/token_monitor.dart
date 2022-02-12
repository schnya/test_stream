import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Manages & returns the users FCM token.
///
/// Also monitors token refreshes and updates state.
class TokenMonitor extends StatefulWidget {
  final Widget Function(String token) _builder;

  const TokenMonitor({
    Key? key,
    required Widget Function(String token) builder,
  })  : _builder = builder,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenMonitor();
}

class _TokenMonitor extends State<TokenMonitor> {
  final Stream<String> _tokenStream = FirebaseMessaging.instance.onTokenRefresh;

  String _token = '';

  void setToken(String? token) {
    // ignore: avoid_print
    print('FCM Token: $token');

    if (token is String) setState(() => _token = token);
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(_token);
  }
}
