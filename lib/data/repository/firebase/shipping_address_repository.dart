import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';

abstract class ShippingAddressRepositoryBase {
  Future<List<ShippingAddressModel>> getCurrentUserShippingAddresses();
  Future<void> addShippingAddress(ShippingAddressModel addressModel);
}

class ShippingAddressRepository extends ShippingAddressRepositoryBase {
  static final ShippingAddressRepository instance =
      ShippingAddressRepository._();
  ShippingAddressRepository._() {
    // final uid = FirebaseAuthRepository.firebaseAuth.currentUser!.uid;

    // _adderssesCollection = firestore
    //     .collection("users")
    //     .doc(uid.trim())
    //     .collection("shippingAddresses");
  }
  final uid = FirebaseAuthRepository.firebaseAuth.currentUser!.uid;

  // late final CollectionReference<Map<String, dynamic>> _adderssesCollection;

  @override
  Future<List<ShippingAddressModel>> getCurrentUserShippingAddresses() async {
    final snapshot = await firestore
        .collection("users")
        .doc(uid.trim())
        .collection("shippingAddresses")
        .orderBy('timeCreated')
        .get();

    final docs = snapshot.docs;
    final addresses = docs
        .map(
          (doc) => ShippingAddressModel.fromMap(doc.data()),
        )
        .toList();

    return addresses;
  }

  @override
  Future<void> addShippingAddress(ShippingAddressModel addressModel) async {
    final docRef = firestore
        .collection("users")
        .doc(uid.trim())
        .collection("shippingAddresses")
        .doc();

    final addedData = addressModel.toMap();
    addedData['timeCreated'] = Timestamp.now();
    addedData['id'] = docRef.id;

    await docRef.set(addedData);
  }
}
