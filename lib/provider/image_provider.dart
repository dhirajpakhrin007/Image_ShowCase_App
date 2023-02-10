import 'package:flutter/cupertino.dart';
import 'package:image_showcase_application/model/image_showcase_model.dart';

class ApiImageProvider extends ChangeNotifier {
  List<Hits>? _imageList;
  bool isLoading = false;

  List<Hits> get images => _imageList!;
  


  setImageList(Future<List<Hits>?> images) async{
    isLoading = true;
    _imageList = await images;
    isLoading = false;
    notifyListeners();
  }

}