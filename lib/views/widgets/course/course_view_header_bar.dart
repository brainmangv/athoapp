import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CourseViewHeaderBar extends SliverPersistentHeaderDelegate {
  // final double minExtend;
  // final double maxExtend;
  final TabBar tabBar;
  final String description;
  final Color color;

  CourseViewHeaderBar(
      {required this.tabBar,
      required this.description,
      Color color = Colors.transparent})
      : this.color = color;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        // Container(
        //   padding: EdgeInsets.all(15),
        //   height: max(0.0, 90 - shrinkOffset),
        //   child: Text(description),
        // ),
        Container(color: color, child: tabBar),
      ],
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height + 0;
  //  throw UnimplementedError();

  @override
  double get minExtent => tabBar.preferredSize.height;
  //  throw UnimplementedError();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
