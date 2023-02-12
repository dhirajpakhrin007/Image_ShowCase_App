import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_showcase_application/model/image_showcase_model.dart';

import '../data/constant.dart';

class ApiImageProvider extends ChangeNotifier {
  List<Hits> _imageList = [];
  List<Hits> _favList = [];

  bool isLoading = false;

  List<Hits> get images => _imageList;
  List<Hits> get favImages => _favList;

  clearList() {
    _favList.clear();
    notifyListeners();
  }

  setImageList(Future<List<Hits>> images) async {
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

  setFavImgList(Hits favorite, BuildContext context) {
    isLoading = true;
    
    if(_favList.contains(favorite)){
      ScaffoldMessenger.of(context)
                                          .showSnackBar(alreadySnackBar);
    }else {
      _favList.add(favorite);
      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
    }
    isLoading = false;
    notifyListeners();
  }
}
