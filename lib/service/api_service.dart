import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_showcase_application/data/url.dart';

import '../model/image_showcase_model.dart';

class ApiService {

  Dio dio = Dio();

  Future<Response> getAllImages() async{
    final response = await dio.get(AppUrl.baseUrl);
    return response;
  }
}