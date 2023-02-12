import 'dart:developer';

import '../model/image_showcase_model.dart';
import '../service/api_service.dart';

class ImageViewModel {
  final _apiService = ApiService();

  //for fetching all images
  Future<List<Hits>> getImagesList() async {
    List res = await _apiService.getAllImages();

    List<Hits> images = res.map((e) => Hits.fromJson(e)).toList();
    log(images[0].id.toString(), name: 'id');
    return images;
  }

  Future<List<Hits>> getSearchList(String key) async {
    log(key, name: 'key');
    List res = await _apiService.getSearchImages(key);
    List<Hits> images = res.map((e) => Hits.fromJson(e)).toList();
    return images;
  }
}
