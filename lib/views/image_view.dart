import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  final String originalUrl;

  const ImageView({
    super.key,
    required this.imgUrl,
    required this.originalUrl,
  });

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool _showContainer = false;
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _showContainer = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: widget.imgUrl,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: _showContainer,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _save();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 35),
                          height: 42,
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white24,
                          ),
                          child: Align(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Align(
                                  child: Text(
                                    'High Quality',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _saveOriginal();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 35),
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Original',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _downloading
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Downloading...",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _save() async {
    setState(() {
      _downloading = true;
    });
    var permissionStatus = await _askPermission();

    if (permissionStatus) {
      var downloadUrl = widget.imgUrl;
      var response = await Dio()
          .get(downloadUrl, options: Options(responseType: ResponseType.bytes));
      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));

      setState(() {
        _downloading = true;
      });

      if (result['isSuccess'] == true) {
        SnackBar snackBar = const SnackBar(
          content: Text("Image Saved"),
          backgroundColor: Colors.green,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  _saveOriginal() async {
    setState(() {
      _downloading = true;
    });
    var permissionStatus = await _askPermission();

    if (permissionStatus) {
      var downloadUrl = widget.originalUrl;
      var response = await Dio().get(
        downloadUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
      );

      setState(() {
        _downloading = false;
      });

      if (result['isSuccess'] == true) {
        SnackBar snackBar = const SnackBar(
          content: Text("Image Saved"),
          backgroundColor: Colors.green,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  _askPermission() async {
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
      return true;
    } else {
      openAppSettings();
    }
  }
}
