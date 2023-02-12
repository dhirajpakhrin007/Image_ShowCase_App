import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/colors.dart';
import '../provider/img_provider.dart';


class FavoriteImage extends StatefulWidget {
  const FavoriteImage({super.key});

  @override
  State<FavoriteImage> createState() => _FavoriteImageState();
}

class _FavoriteImageState extends State<FavoriteImage> {
  // warning dialog for removing favorite image
  void _showRemoveDialog(BuildContext context, Function() action) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Wait!!'),
            content: const Text('Do you want to remove this image from favorite'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close')),
              TextButton(
                onPressed:action,
                child: Text('Ok'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar( 
          leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          centerTitle: true,
          backgroundColor: ColorConstant.primaryColor,
          title: const Text(
            'Favourite Images',
            style: TextStyle(
              color: ColorConstant.bgColor,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<ApiImageProvider>(context, listen: false)
                      .clearList();
                },
                icon: const Icon(
                  Icons.highlight_remove_rounded,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorConstant.bgColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25.0),
            child: Column(
              children: [
                SizedBox(
                    height: size.height * 0.02,
                  ),
                  Consumer<ApiImageProvider>(builder: (context, img, child) {
                    return img.favImages.isEmpty
                        ? SizedBox()
                        : img.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : Expanded(
                                child: GridView.builder(
                                  itemCount: img.favImages.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        _showRemoveDialog(context, () {
                                          setState(() {
                                            img.favImages.removeAt(index);
                                          Navigator.pop(context);
                                          });
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Image.network(
                                              img.favImages[index].largeImageURL
                                                  .toString(),
                                              height: img.favImages[index].imageHeight!
                                                  .toDouble(),
                                              width: img.favImages[index].imageWidth!
                                                  .toDouble(),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            img.favImages[index].user.toString(),
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            img.favImages[index].imageSize.toString() + " KB",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    crossAxisCount: 2,
                                  ),
                                ),
                              );
                  })
              ],
            ),
          ),
        ),
      )
    );
  }
}