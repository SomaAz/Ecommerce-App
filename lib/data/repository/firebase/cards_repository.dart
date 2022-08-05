import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:ecommerce_getx/data/repository/firebase/auth_repository.dart';

abstract class CardsRepositoryBase {
  Future<List<CardModel>> getCurrentUserCards();
  Future<void> addCard(CardModel cardModel);
  Future<CardModel?> getCurrentUserFirstCard();
}

class CardsRepository extends CardsRepositoryBase {
  static final CardsRepository instance = CardsRepository._();
  CardsRepository._();

  final _cardsCollectionReference = firestore
      .collection("users")
      .doc(FirebaseAuthRepository.firebaseAuth.currentUser!.uid.trim())
      .collection("cards");
  // late final CollectionReference<Map<String, dynamic>> _cardsCollection;

  @override
  Future<List<CardModel>> getCurrentUserCards() async {
    final snapshot =
        await _cardsCollectionReference.orderBy('timeCreated').get();

    final docs = snapshot.docs;
    final cards = docs
        .map(
          (doc) => CardModel.fromMap(doc.data()),
        )
        .toList();

    return cards;
  }

  @override
  Future<void> addCard(CardModel cardModel) async {
    final docRef = _cardsCollectionReference.doc();

    final addedData = cardModel.toMap();
    addedData['timeCreated'] = Timestamp.now();
    addedData['id'] = docRef.id;

    await docRef.set(addedData);
  }

  @override
  Future<CardModel?> getCurrentUserFirstCard() async {
    final snapshot =
        await _cardsCollectionReference.orderBy('timeCreated').limit(1).get();

    final doc = snapshot.docs.first;
    if (doc.exists) {
      final address = CardModel.fromMap(doc.data());

      return address;
    }
    return null;
  }
}