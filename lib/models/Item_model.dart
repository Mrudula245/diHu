import 'dart:ui';

import 'package:flutter/material.dart';

class Item {

  final String image, title;
  final int id ;
  final Color color;
  final VoidCallback? onTap;
  Item({
    required this.image,
    required this.title,
    required this.onTap,

    required this.color,
    required this.id,
  });
}

