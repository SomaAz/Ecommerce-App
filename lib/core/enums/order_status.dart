import 'package:flutter/material.dart';

enum OrderStatus {
  processing("Processing", Colors.orange),
  delivered("Delivered", Colors.green),
  canceled("Canceled", Colors.red);

  const OrderStatus(this.name, this.color);
  final String name;
  final Color color;
}
