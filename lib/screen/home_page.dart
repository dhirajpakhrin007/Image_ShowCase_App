import 'package:flutter/material.dart';
import 'package:image_showcase_application/data/colors.dart';
import 'package:image_showcase_application/repository/get_image_view_model.dart';
import 'package:provider/provider.dart';

import '../provider/image_provider.dart';
import '../service/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ApiImageProvider>(context, listen: false)
        .setImageList(ImageViewModel().getImagesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorConstant.primaryColor,
          title: const Text(
            'Image ShowCase',
            style: TextStyle(
              color: ColorConstant.bgColor,
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorConstant.bgColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Seach For The Best Images',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "eg: Yellow Flower",
                          focusColor: Colors.white,
                          hintStyle: const TextStyle(
                            color: Colors.white54,
                          )
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
                        height: size.height * 0.065,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Consumer<ApiImageProvider>(builder: (context, img, child) {
                  return img.isLoading
                      ? Center(
                        child: const CircularProgressIndicator())
                      : Expanded(
                          child: GridView.builder(
                            itemCount: img.images.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      img.images[index].userImageURL.toString(),
                                      height: img.images[index].imageHeight!
                                          .toDouble(),
                                      width: img.images[index].imageWidth!
                                          .toDouble(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    img.images[index].user.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    img.images[index].imageSize.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
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
      ),
    );
  }
}
