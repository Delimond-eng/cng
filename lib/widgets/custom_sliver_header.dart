import 'package:cng/components/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HeaderSliver implements SliverPersistentHeaderDelegate {
  final double maxExtent;
  final double minExtent;
  final Widget child;

  HeaderSliver({@required this.maxExtent, this.minExtent, this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CustomHeader(
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      null;

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  TickerProvider get vsync => null;
}
