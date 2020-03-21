import 'package:dio/dio.dart';
import 'dart:async';

import 'package:yangjiegeng/utils/JSON.dart';
/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class HttpUtils {

  /// global dio object
  static Dio dio;

  /// default options
  static const String API_PREFIX = 'http://192.168.2.223:8080/v1/';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  /// request method
  // ignore: missing_return
  static Future<Map> request (String url, { data, method }) async {
    Dio dio = createInstance();
    try {
      Response response = await dio.request(API_PREFIX+url, data: data, options: new Options(method: method));
      var result = response.data;
      /// 打印响应相关信息
      print('响应数据：接受成功');
      return result;
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
    }
  }



  static Future<int> pd(String url,{data,method}) async{
    Dio dio=createInstance();
    int pd;
    try {
      Response response = await dio.request(API_PREFIX+url, data: data, options: new Options(method: method));
      var text= response.data;
      /// 打印响应相关信息
      print('响应数据：' + response.toString());
      print(response.headers);
      JSON json = JSON.fromJson(text);
      var msg=(json.msg);
      if(msg=="login success"){
        pd=0;
      }else if(msg=="password error"){
        print("密码错误");
        pd=2;
      }else if(msg=="user not exist"){
        print("用户不存在");
        pd=1;
      }else{
        pd=3;//请求出错
      }
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
    }
    return pd;
  }
  /// 创建 dio 实例对象
  static Dio createInstance () {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      Options options = new Options(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      dio = new Dio(options);
    }
    return dio;
  }
  /// 清空 dio 对象
  static clear () {
    dio = null;
  }
}