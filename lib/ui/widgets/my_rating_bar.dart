import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:phinex/utils/consts.dart';

class MyRatingBar extends StatefulWidget {
  final double rate;
  final bool ignoreGestures;
  final double Function(double) onRatingUpdate;
  final double itemSize;

  const MyRatingBar({
    Key key,
    @required this.rate,
    this.ignoreGestures = true,
    this.onRatingUpdate,
    this.itemSize = 14,
  }) : super(key: key);

  @override
  _MyRatingBarState createState() => _MyRatingBarState();
}

class _MyRatingBarState extends State<MyRatingBar> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: widget.rate ?? 0,
      minRating: 1,
      itemSize: widget.itemSize,
      ignoreGestures: widget.ignoreGestures,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: goldColor,
      ),
      onRatingUpdate: widget.onRatingUpdate,
    );
  }
}
