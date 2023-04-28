import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regwalls/model/wallpaper_mode.dart';
import 'package:regwalls/views/image_view.dart';
import 'dart:async';



Widget brandName() {
  return Center(
    child: RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        children: <TextSpan>[
          TextSpan(text: 'Reg', style: TextStyle(color: Colors.white)),
          TextSpan(text: 'Walls', style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
  );
}

Widget wallpapersList({required List<WallpaperModel> wallpapers, context, required ScrollController scrollController}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        controller: scrollController,
        itemCount: wallpapers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          if (index == wallpapers.length - 1) {
            // We have reached the end of the current list, display a loading indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            WallpaperModel wallpaper = wallpapers[index];
            return GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ImageView(imgUrl: wallpaper.src!.portrait, originalUrl: wallpaper.src!.original)
                  ));
                },
                child: Hero(
                  tag: wallpaper.src!.portrait,
                  child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          wallpaper.src!.portrait,
                          fit: BoxFit.cover,),
                      )),
                ),
              ),
            );
          }
        },
      ),
    ),
  );
}



