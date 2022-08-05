import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/core/enums/delivery_type.dart';
import 'package:ecommerce_getx/core/enums/order_status.dart';
import 'package:ecommerce_getx/data/model/cart_product_model.dart';
import 'package:flutter/foundation.dart';

import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';

class OrderModel {
  final String id;
  final OrderStatus status;
  final ShippingAddressModel shippingAddress;
  final CardModel paymentCard;
  final Timestamp timeOrdered;
  final int number;
  final double price;
  final DeliveryType deliveryType;
  final List<CartProductModel> products;

  OrderModel({
    required this.id,
    required this.status,
    required this.shippingAddress,
    required this.paymentCard,
    required this.timeOrdered,
    required this.number,
    required this.price,
    required this.deliveryType,
    required this.products,
  });

  OrderModel copyWith({
    String? id,
    OrderStatus? status,
    ShippingAddressModel? shippingAddress,
    CardModel? paymentCard,
    Timestamp? timeOrdered,
    int? number,
    double? price,
    DeliveryType? deliveryType,
    List<CartProductModel>? products,
  }) {
    return OrderModel(
      id: id ?? this.id,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentCard: paymentCard ?? this.paymentCard,
      timeOrdered: timeOrdered ?? this.timeOrdered,
      number: number ?? this.number,
      price: price ?? this.price,
      deliveryType: deliveryType ?? this.deliveryType,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.name,
      'shippingAddress': shippingAddress.toMap(),
      'paymentCard': paymentCard.toMap(),
      'timeOrdered': timeOrdered,
      'number': number,
      'price': price,
      'deliveryType': deliveryType.name,
      'products': products.map((product) => product.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      status: OrderStatus.values
          .firstWhere((status) => status.name == map['status']),
      shippingAddress: ShippingAddressModel.fromMap(map['shippingAddress']),
      paymentCard: CardModel.fromMap(map['paymentCard']),
      timeOrdered: map['timeOrdered'],
      number: map['number']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      deliveryType: DeliveryType.values
          .firstWhere((type) => type.name == map['deliveryType']),
      products: List<CartProductModel>.from(
        map['products']?.map((x) => CartProductModel.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, status: $status, shippingAddress: $shippingAddress, paymentCard: $paymentCard, timeOrdered: $timeOrdered, number: $number, price: $price, deliveryType: $deliveryType, products: $products)'
        .replaceAll(",", ", ");
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.status == status &&
        other.shippingAddress == shippingAddress &&
        other.paymentCard == paymentCard &&
        other.timeOrdered == timeOrdered &&
        other.number == number &&
        other.price == price &&
        other.deliveryType == deliveryType &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        shippingAddress.hashCode ^
        paymentCard.hashCode ^
        timeOrdered.hashCode ^
        number.hashCode ^
        price.hashCode ^
        deliveryType.hashCode ^
        products.hashCode;
  }
}
