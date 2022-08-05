import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';

abstract class OrdersRepositoryBase {
  Future<void> placeOrder(OrderModel order);
  Future<List<OrderModel>> getAllOrders();
}

class OrdersRepository extends OrdersRepositoryBase {
  static final OrdersRepository instance = OrdersRepository._();
  OrdersRepository._();

  final _ordersCollection = firestore
      .collection("users")
      .doc(FirebaseAuthRepository.firebaseAuth.currentUser!.uid.trim())
      .collection("orders");

  @override
  Future<void> placeOrder(OrderModel order) async {
    final docRef = _ordersCollection.doc();

    final addedData = order.toMap();
    addedData['id'] = docRef.id;

    await docRef.set(addedData);
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final snapshot = await _ordersCollection.orderBy("timeOrdered").get();

    final orders =
        snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();

    return orders;
  }
}
