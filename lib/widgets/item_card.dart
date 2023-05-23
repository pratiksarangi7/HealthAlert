import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String image;
  final String label;
  final bool isTapped;
  const ItemCard(
      {Key? key,
      required this.image,
      required this.label,
      required this.isTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outlineColor = Colors.grey.withOpacity(0.9);
    if (isTapped) {
      outlineColor = Color.fromARGB(255, 0, 128, 96);
    }
    return Column(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(color: outlineColor),
            borderRadius: BorderRadius.circular(30.0),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 18, color: outlineColor),
        ),
      ],
    );
  }
}
