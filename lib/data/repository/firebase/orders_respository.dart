import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';

abstract class OrdersRepositoryBase {
  Future<void> placeOrder(OrderModel order);
  Future<List<OrderModel>> getAllOrders();
  Future<int> getOrderNumber();
}

class OrdersRepository extends OrdersRepositoryBase {
  static final OrdersRepository instance = OrdersRepository._();
  OrdersRepository._();

  final _ordersCollection = firestore.collection("orders");

  @override
  Future<void> placeOrder(OrderModel order) async {
    final docRef = _ordersCollection.doc();

    final addedData = order.toMap();
    addedData['id'] = docRef.id;
    addedData['number'] = await getOrderNumber();
    addedData['userId'] = FirebaseAuthRepository.firebaseAuth.currentUser!.uid;

    await docRef.set(addedData);
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final userId = FirebaseAuthRepository.firebaseAuth.currentUser!.uid;
    final snapshot = await _ordersCollection
        .orderBy("timeOrdered", descending: true)
        .where("userId", isEqualTo: userId)
        .get();

    final orders =
        snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();

    return orders;
  }

  @override
  Future<int> getOrderNumber() async {
    final snapshot = await _ordersCollection
        .orderBy("number", descending: true)
        .limit(1)
        .get();
    log(snapshot.docs.toString());
    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;

      final orderModel = OrderModel.fromMap(doc.data());

      final prevOrderNumber = orderModel.number;
      final currentOrderNumber = prevOrderNumber + 1;

      return currentOrderNumber;
    }

    return 1;
  }
}
