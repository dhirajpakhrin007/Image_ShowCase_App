import 'dart:developer';

import '../model/image_showcase_model.dart';
import '../service/api_service.dart';

class ImageViewModel {

  Future<List<Hits>?> getImagesList() async{
    final res = await ApiService().getAllImages();
    try {
      if(res.statusCode == 200) {
        List data = res.data['hits'];
      List<Hits> images = data.map((e) => Hits.fromJson(e)).toList();
      log(images[1].userImageURL.toString());
      return images;
      }
    } catch(e) {
      throw e;
    }

  }
}