import 'dart:async';

import 'package:flutter/services.dart';

class FacebookDeeplinks {

  /// 生成单例类
  FacebookDeeplinks._instance();
  static final FacebookDeeplinks _singleton = FacebookDeeplinks._instance();

  factory FacebookDeeplinks() {
    return _singleton;
  }

  static const MethodChannel _methodChannel =
      const MethodChannel('ru.proteye/facebook_deeplinks/channel');
  final EventChannel _eventChannel =
      const EventChannel('ru.proteye/facebook_deeplinks/events');
  late Stream<String> _onDeeplinkReceived;
  /// Gets the initial URL.
  Future<String?> getInitialUrl() async {
    try {
       String? url =  await _methodChannel.invokeMethod('initialUrl');
       return Future.value(url);
    } on PlatformException catch (e) {
      print("Failed to Invoke: '${e.message}'.");
      return Future.value('');
    }
  }

  /// Stream of changes by URL.
  Stream<String> get onDeeplinkReceived {
      _onDeeplinkReceived =
          _eventChannel.receiveBroadcastStream().cast<String>();
    return _onDeeplinkReceived;
  }
}
