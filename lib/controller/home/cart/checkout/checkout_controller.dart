import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/controller/home/cart/cart_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/enums/delivery_type.dart';
import 'package:ecommerce_getx/core/enums/order_status.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:ecommerce_getx/data/model/cart_product_model.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  //? Delivery Type
  DeliveryType _selectedDeliveryType = DeliveryType.standard;
  DeliveryType get selectedDeliveryType => _selectedDeliveryType;

  changeDeliveryType(DeliveryType newDeliveryType) {
    _selectedDeliveryType = newDeliveryType;
    update();
  }

  //? Address

  late ShippingAddressModel _selectedShippingAddress;
  ShippingAddressModel get selectedShippingAddress => _selectedShippingAddress;

  Future<void> setSelectedShippingAddress() async {
    _selectedShippingAddress =
        (await shippingAdressRepository.getCurrentUserFirstShippingAddress())!;
  }

  Future<void> changeSelectedUserAddress() async {
    final newAddress = await Get.toNamed(
      AppRoutes.shippingAddress,
      arguments: {"id": _selectedShippingAddress.id},
    );
    if (newAddress != null) {
      _selectedShippingAddress = newAddress;
      update();
    }
  }

  //? Card
  late CardModel _selectedCard;
  CardModel get selectedCard => _selectedCard;

  Future<void> setSelectedCard() async {
    _selectedCard = (await cardsRepository.getCurrentUserFirstCard())!;
  }

  Future<void> changeSelectedUserCard() async {
    final newCard = await Get.toNamed(
      AppRoutes.cards,
      arguments: {"id": _selectedCard.id},
    );
    if (newCard != null) {
      _selectedCard = newCard;
      update();
    }
  }

  //? Prices
  late final double _orderPrice;
  double get orderPrice => _orderPrice;

  double get deliveryPrice {
    return selectedDeliveryType.price;
  }

  double get totalPrice {
    return _orderPrice + deliveryPrice;
  }

  //? Products
  late final List<CartProductModel> _orderedProducts;
  List<CartProductModel> get orderedProducts => _orderedProducts;

  //? Orders
  bool _isPlacingOrderLoading = false;
  bool get isPlacingOrderLoading => _isPlacingOrderLoading;

  void setisPlacingOrderLoading(bool value) {
    _isPlacingOrderLoading = value;
    update();
  }

  Future<void> _placeOrder() async {
    final orderModel = OrderModel(
      id: "",
      timeOrdered: Timestamp.now(),
      status: OrderStatus.processing,
      shippingAddress: _selectedShippingAddress,
      paymentCard: _selectedCard,
      number: 2500,
      price: totalPrice,
      deliveryType: _selectedDeliveryType,
      products: _orderedProducts,
    );
    await Future.delayed(const Duration(seconds: 2));
    await ordersRepository.placeOrder(orderModel);
  }

  Future<void> placeOrder() async {
    setisPlacingOrderLoading(true);

    await _placeOrder().then((value) async {
      await Get.find<CartController>().clearCartProducts();
      Get.back();
      Get.snackbar("Success", "Order Placed Successfully");
    });

    setisPlacingOrderLoading(false);
  }

  Future<void> loadData() async {
    setIsLoading(true);
    await Future.wait([setSelectedShippingAddress(), setSelectedCard()]);
    setIsLoading(false);
  }

  Future<void> refreshData() async {
    await Future.wait([setSelectedShippingAddress(), setSelectedCard()]);
    update();
  }

  @override
  void onInit() async {
    _orderPrice = Get.arguments['price'];
    _orderedProducts = Get.arguments['products'];
    await loadData();
    super.onInit();
  }
}
