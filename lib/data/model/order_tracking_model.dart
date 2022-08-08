import 'dart:convert';

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

  OrderTrackingModel copyWith({
    String? title,
    String? location,
    Timestamp? timeChecked,
  }) {
    return OrderTrackingModel(
      title: title ?? this.title,
      location: location ?? this.location,
      timeChecked: timeChecked ?? this.timeChecked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'timeChecked': timeChecked,
    };
  }

  factory OrderTrackingModel.fromMap(Map<String, dynamic> map) {
    return OrderTrackingModel(
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      timeChecked: map['timeChecked'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderTrackingModel.fromJson(String source) =>
      OrderTrackingModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OrderTrackingModel(title: $title, location: $location, timeChecked: $timeChecked)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderTrackingModel &&
        other.title == title &&
        other.location == location &&
        other.timeChecked == timeChecked;
  }

  @override
  int get hashCode => title.hashCode ^ location.hashCode ^ timeChecked.hashCode;
}
