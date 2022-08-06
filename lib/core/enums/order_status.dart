import 'package:flutter/material.dart';

enum OrderStatus {
  processing("processing", Colors.orange),
  delivered("delivered", Colors.green),
  canceled("canceled", Colors.red);

  const OrderStatus(this.name, this.color);
  final String name;
  final Color color;
}
