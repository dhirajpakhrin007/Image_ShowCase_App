import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:image_showcase_application/model/image_showcase_model.dart';

class ApiImageProvider extends ChangeNotifier {
  List<Hits> _imageList = [];
  bool isLoading = false;

  List<Hits> get images => _imageList;

  clearList() {
    _imageList.clear();
    notifyListeners();
  }

  setImageList(Future<List<Hits>> images) async{
    isLoading = true;

    _imageList = await images;
    isLoading = false;
    notifyListeners();
  }

  setSearchList(Future<List<Hits>> search) async {

    isLoading = true;
    _imageList = await search;
    isLoading = false;
    notifyListeners();
  }
}
