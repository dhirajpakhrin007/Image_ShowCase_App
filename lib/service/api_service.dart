import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_showcase_application/data/url.dart';

import '../model/image_showcase_model.dart';

class ApiService {

  Dio dio = Dio();
  

  Future getAllImages() async{
    final response = await dio.get(AppUrl.baseUrl);
    return response.data['hits'];
  }

  Future getSearchImages(String keyword) async{
    log(keyword, name: 'keyword');
    log(AppUrl.baseUrl+keyword, name: 'keyword');

    final response = await dio.get(AppUrl.searchUrl+keyword);
    return response.data['hits'];
  }
}