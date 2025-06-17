import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

class AppException implements Exception {
  late final String message;

  AppException(String? message) {
    this.message = message ?? "Something went wrong";
  }

  factory AppException.fromResponse(Response r) {
    log(r.body);
    return AppException(jsonDecode(r.body)['message']);
  }
}
