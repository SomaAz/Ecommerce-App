import 'package:ecommerce_getx/data/service/firebase/auth_service.dart';
import 'package:ecommerce_getx/data/service/firebase/firestore_service.dart';
import 'package:get/get.dart';

final FirebaseAuthService authService = FirebaseAuthService.instance;
final FirestoreService firestoreService = FirestoreService.instance;

double get productCardHeight => (Get.height * .3);
