import 'package:flutter/material.dart';

import 'category_image.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  const CategoryTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryImage(categoryName: title.toLowerCase())));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white24,
          ),
          height: 50,
          width: 100,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
