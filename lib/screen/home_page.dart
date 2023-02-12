import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_showcase_application/data/colors.dart';
import 'package:image_showcase_application/model/image_showcase_model.dart';
import 'package:image_showcase_application/repository/get_image_view_model.dart';
import 'package:provider/provider.dart';

import '../provider/img_provider.dart';
import '../service/api_service.dart';
import 'fav_image.dart';

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

  final searchController = TextEditingController();
  final searchFocus = FocusNode();

  bool isError = false;
  final _formKey = GlobalKey<FormState>();

  void _onSearch() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      searchFocus.unfocus();
      Provider.of<ApiImageProvider>(context, listen: false)
          .setSearchList(ImageViewModel().getSearchList(searchController.text));
    }
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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavoriteImage()));
                },
                icon: Icon(
                  Icons.star,
                  color: ColorConstant.favColor,
                  size: 35.0,
                ))
          ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          focusNode: searchFocus,
                          controller: searchController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter image name";
                            }
                            return null;
                          },
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
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                searchController.clear();
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        _onSearch();
                      },
                      child: Container(
                          height: size.height * 0.075,
                          width: size.width * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Consumer<ApiImageProvider>(builder: (context, img, child) {
                  return img.images.isEmpty
                      ? SizedBox()
                      : img.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : Expanded(
                              child: GridView.builder(
                                itemCount: img.images.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      img.setFavImgList(
                                          img.images[index], context);
                                    },
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            img.images[index].largeImageURL
                                                .toString(),
                                            height: img
                                                .images[index].imageHeight!
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
                                          img.images[index].imageSize
                                              .toString() + " KB",
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
      ),
    );
  }
}
