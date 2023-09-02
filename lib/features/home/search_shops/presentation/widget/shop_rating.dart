import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShopRating extends StatelessWidget {
  const ShopRating({
    super.key,
    required this.rate,
    this.itemPadding,
  });

  final double rate;
  final EdgeInsetsGeometry? itemPadding;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      glow: true,
      itemPadding: itemPadding ?? const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
      itemSize: 15,
    );
  }
}
