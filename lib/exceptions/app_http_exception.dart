import 'package:test_task/exceptions/app_base_exteption.dart';

class AppHttpException extends AppBaseExteption {
  final int? errorCode;
  final String? message;

  AppHttpException({this.errorCode, this.message});
}
