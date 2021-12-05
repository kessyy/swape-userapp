import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:swape_user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:swape_user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:swape_user_app/data/model/response/base/api_response.dart';
import 'package:swape_user_app/utill/app_constants.dart';

class BrandRepo {
  final DioClient dioClient;
  BrandRepo({@required this.dioClient});

  Future<ApiResponse> getBrandList(String languageCode) async {
    try {
      final response = await dioClient.get(
        AppConstants.BRANDS_URI,
        options: Options(headers: {AppConstants.LANG_KEY: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
