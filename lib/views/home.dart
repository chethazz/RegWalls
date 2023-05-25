import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regwalls/data/data.dart';
import 'package:regwalls/model/categories_model.dart';
import 'package:regwalls/model/wallpaper_mode.dart';
import 'package:regwalls/views/search.dart';
import 'package:regwalls/widget/widget.dart';
import 'package:http/http.dart' as http;

import 'category_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchController = TextEditingController();

  getTrendingWallpapers() async {
    var response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=20&page=1'),
      headers: {"Authorization": apiKey},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  void fetchMoreWallpapers() async {
    var response = await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/curated?per_page=100&page=${wallpapers.length ~/ 20 + 1}'),
      headers: {"Authorization": apiKey},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    List<WallpaperModel> newWallpapers = [];
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      newWallpapers.add(wallpaperModel);
    });

    setState(() {
      wallpapers.addAll(newWallpapers);
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User has scrolled to the end of the list, fetch more wallpapers
      fetchMoreWallpapers();
    }
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: brandName(),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (kDebugMode) {
                            print("Search ${searchController.text}");
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(
                                searchQuery: searchController.text,
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 50,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(
                  androidOverscrollIndicator:
                      AndroidOverscrollIndicator.stretch),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    title: categories[index].categoryName,
                  );
                },
              ),
            ),
          ),
          wallpapersList(
            wallpapers: wallpapers,
            context: context,
            scrollController: _scrollController,
          )
        ],
      ),
    );
  }
}
