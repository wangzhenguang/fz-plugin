import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';


enum Toast {
  SHORT,
  LONG
}

enum ToastGravity {
  CENTER,
  BOTTOM
}


class FzPlugin {
  static const MethodChannel _channel =
  const MethodChannel('fz_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> toast({
    @required String msg,
    Toast toastLength = Toast.SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM
  }) async {
    final String result = await _channel.invokeMethod('toast', {
      "msg": msg,
      "length": toastLength == Toast.LONG ? "long" : "short",
      "gravity": gravity == ToastGravity.BOTTOM ? "bottom" : "center"
    });
    return result;
  }


}
