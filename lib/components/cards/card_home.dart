import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CardHome({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias, // prevents overflow of image corners
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 👇 The Expanded fixes overflow by resizing the image area dynamically
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // 👇 Text under the image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
