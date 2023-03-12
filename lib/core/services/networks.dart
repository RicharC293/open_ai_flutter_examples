import 'package:chatgpt_test/env/env.dart';
import 'package:dio/dio.dart';

class Network {
  static final Network _network = Network._internal();

  factory Network() {
    return _network;
  }

  Network._internal();

  get requestExternal => _requestExternal;

  final Dio _requestExternal = Dio();

  void setExternalRequest() {
    _requestExternal.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      options.headers = {
        /// Important
        /// Read the README.md file to know how to use the .env file
        ///
        "Authorization": "Bearer ${Env.openAiKey}",
        "Content-Type": "application/json",
      };
      return handler.next(options);
    }));
  }
}
