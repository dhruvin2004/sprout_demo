import 'dart:async';

import 'package:dio/dio.dart';
import 'package:new_project_setup/constants/utils.dart';

import '../common_model/common_response.dart';
import '../constants/app.export.dart';


class AppInterceptors extends Interceptor {
  // Function? before;
  // Function? after;
  Function? callback;
  bool? isShowToast;

  AppInterceptors({
    // this.after,
    // this.before,
    this.callback,
    this.isShowToast,
  });

  @override
  FutureOr<dynamic> onRequest(RequestOptions options, handler) async {
    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    print("====== ERROR ======== ${err.toString()}");
    print("====== ERROR ======== ${err.response?.realUri}");
    print("====== ERROR ======== ${err.response?.statusCode}");
    print("====== ERROR ======== ${err.response?.data}");
    if (err.response!.statusCode == 401) {
      debugPrint("IN APP INTERCEPTOR ERROR");
      await Utils.performLogout();
      return null;
    }
    // if (err.response?.statusCode == 401) {
    //   RequestOptions options = err.response!.requestOptions;
    //   CommonResponse commonResponse = CommonResponse.fromJson(err.response!.data);
    //
    //   await Utils.performRefreshToken().then((value) async {
    //     callback!(options, err, handler);
    //   });
    // } else {
    Utils.showCircularProgressLottie(false);
    if(isShowToast! && err.response!.data["message"] != null && err.response!.data["message"] != "") Utils.showErrToast(err.response!.data["message"]);
    CommonResponse commonResponse;
    commonResponse = CommonResponse.fromJson(err.response!.data);
    if (err.response!.data["errors"] != null) {
      if (err.response!.data["errors"][0]["message"] != null) {
        Utils.showErrToast(err.response!.data["errors"][0]["message"]);
      } else {
        if (commonResponse.message != null) {
          Utils.showErrToast(commonResponse.message);
        }
      }
    }
    // Utils.showCircularProgressLottie(false);
    return commonResponse;
    // return handler.reject(err);
    // }
  }

  @override
  FutureOr<dynamic> onResponse(response, ResponseInterceptorHandler handler) async {
    print("==== STATUS CODE IN ON RESPONSE ${response.realUri}");
    print("==== STATUS CODE IN ON RESPONSE ${response.statusCode}");
    if (response.statusCode == 401) {
      // Utils.performRefreshToken();
    } else {
      return handler.next(response);
    }
  }
}
