import 'dart:core';

import 'package:flutter/foundation.dart';

class HttpException implements Exception {
  final String message;

  HttpException({
    @required this.message,
  }) : assert(message != null);

  @override
  String toString() {
    return '$message';
  }
}
