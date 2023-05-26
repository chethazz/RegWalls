import 'package:flutter/material.dart';
import 'category_image.dart';

class CategoryTile extends StatelessWidget {
  final String title;

  const CategoryTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      alignment: Alignment.center,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          primary: Colors.white24,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
        ),
        onPressed: () {
          Future.delayed(const Duration(milliseconds: 150), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CategoryImage(categoryName: title.toLowerCase())));
          });
        },
        child: Container(
          alignment: Alignment.center,
          width: 80,
          height: 26,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
        ),
      );
  }
}
