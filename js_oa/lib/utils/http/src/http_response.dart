import 'http_exceptions.dart';

class HttpResponse {
  late bool ok;
  dynamic data;
  HttpException? error;

  /// 单例对象
  static HttpResponse _instance = HttpResponse._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  HttpResponse._internal({this.ok = false});

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory HttpResponse.getInstance() => _instance;

  HttpResponse.success(this.data) {
    this.ok = true;
  }

  HttpResponse.failure({String? errorMsg, int? errorCode}) {
    this.error = BadRequestException(message: errorMsg, code: errorCode);
    this.ok = false;
  }

  HttpResponse.failureFromResponse({dynamic data}) {
    this.error = BadResponseException(data);
    this.ok = false;
  }

  HttpResponse.failureFromError([HttpException? error]) {
    this.error = error ?? UnknownException();
    this.ok = false;
  }
}