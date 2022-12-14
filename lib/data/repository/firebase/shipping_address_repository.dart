import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/repositories.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';

abstract class ShippingAddressRepositoryBase {
  Future<List<ShippingAddressModel>> getCurrentUserShippingAddresses();
  Future<void> addShippingAddress(ShippingAddressModel addressModel);
  Future<ShippingAddressModel?> getCurrentUserFirstShippingAddress();
  Future<void> deleteShippingAddress(ShippingAddressModel deletedAddressModel);
  Future<void> editShippingAddress(ShippingAddressModel editedAddressModel);
}

class ShippingAddressRepository extends ShippingAddressRepositoryBase {
  static final ShippingAddressRepository instance =
      ShippingAddressRepository._();
  ShippingAddressRepository._();

  final _shippingAdressessCollectionRef = AppRepositories.firestore
      .collection("users")
      .doc(FirebaseAuthRepository.firebaseAuth.currentUser!.uid.trim())
      .collection("shippingAddresses");

  @override
  Future<List<ShippingAddressModel>> getCurrentUserShippingAddresses() async {
    final snapshot =
        await _shippingAdressessCollectionRef.orderBy('timeCreated').get();

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
    final docRef = _shippingAdressessCollectionRef.doc();

    final addedData = addressModel.toMap();
    addedData['timeCreated'] = Timestamp.now();
    addedData['id'] = docRef.id;

    await docRef.set(addedData);
  }

  @override
  Future<ShippingAddressModel?> getCurrentUserFirstShippingAddress() async {
    final snapshot = await _shippingAdressessCollectionRef
        .orderBy('timeCreated')
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      if (doc.exists) {
        final address = ShippingAddressModel.fromMap(doc.data());

        return address;
      }
    }
    return null;
  }

  @override
  Future<void> deleteShippingAddress(
      ShippingAddressModel deletedAddressModel) async {
    final docRef = _shippingAdressessCollectionRef.doc(deletedAddressModel.id);

    await docRef.delete();
  }

  @override
  Future<void> editShippingAddress(
      ShippingAddressModel editedAddressModel) async {
    final docRef =
        _shippingAdressessCollectionRef.doc(editedAddressModel.id.trim());

    await docRef.update(editedAddressModel.toMap());
  }
}
