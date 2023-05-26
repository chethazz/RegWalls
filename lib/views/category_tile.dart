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
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          primary: Colors.white24,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CategoryImage(categoryName: title.toLowerCase())));
        },
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
        ),
        ),
      );
  }
}
