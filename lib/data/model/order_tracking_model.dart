import 'package:cloud_firestore/cloud_firestore.dart';

class OrderTrackingModel {
  final String title;
  final String location;
  final Timestamp? timeChecked;

  OrderTrackingModel({
    required this.title,
    required this.location,
    this.timeChecked,
  });
}
