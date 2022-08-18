import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_getx/controller/home/cart/cart_controller.dart';
import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/enums/delivery_type.dart';
import 'package:ecommerce_getx/core/enums/order_status.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:ecommerce_getx/data/model/cart_product_model.dart';
import 'package:ecommerce_getx/data/model/order_model.dart';
import 'package:ecommerce_getx/data/model/order_tracking_model.dart';
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

  late ShippingAddressModel? _selectedShippingAddress;
  ShippingAddressModel? get selectedShippingAddress => _selectedShippingAddress;

  Future<void> setSelectedShippingAddress() async {
    _selectedShippingAddress =
        (await shippingAdressRepository.getCurrentUserFirstShippingAddress());
  }

  Future<void> changeSelectedUserAddress() async {
    final newAddress = await Get.toNamed(
      AppRoutes.shippingAddress,
      arguments: {"fromCheckout": true, "id": _selectedShippingAddress?.id},
    );
    if (newAddress != null) {
      _selectedShippingAddress = newAddress;
      update();
    }
  }

  //? Card
  late CardModel? _selectedCard;
  CardModel? get selectedCard => _selectedCard;

  Future<void> setSelectedCard() async {
    _selectedCard = (await cardsRepository.getCurrentUserFirstCard())!;
  }

  Future<void> changeSelectedUserCard() async {
    final newCard = await Get.toNamed(
      AppRoutes.cards,
      arguments: {"fromCheckout": true, "id": _selectedCard?.id},
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

  void setIsPlacingOrderLoading(bool value) {
    _isPlacingOrderLoading = value;
    update();
  }

  Future<bool> _placeOrder() async {
    if (_selectedShippingAddress == null) {
      Get.snackbar(
        "",
        "You Have To Add A Shipping Address To Continue Ordering",
      );
      return false;
    }
    if (_selectedCard == null) {
      Get.snackbar(
        "",
        "You Have To Add A Payment Card To Continue Ordering",
      );
      return false;
    }
    final customerLocation =
        "${_selectedShippingAddress!.state}, ${_selectedShippingAddress!.country}";

    final List<OrderTrackingModel> starterTrackings = [
      OrderTrackingModel(
        title: "Order Placed",
        location: customerLocation,
        timeChecked: Timestamp.now(),
      ),
      OrderTrackingModel(
        title: "Order Signed",
        location: customerLocation,
      ),
      OrderTrackingModel(
        title: "Order Processed",
        location: customerLocation,
      ),
      OrderTrackingModel(
        title: "Shipped",
        location: customerLocation,
      ),
      OrderTrackingModel(
        title: "Delivered",
        location: customerLocation,
      ),
      OrderTrackingModel(
        title: "Out for delivery",
        location: customerLocation,
      ),
    ];

    final orderModel = OrderModel(
      id: "",
      number: -1,
      timeOrdered: Timestamp.now(),
      status: OrderStatus.processing,
      shippingAddress: _selectedShippingAddress!,
      paymentCard: _selectedCard!,
      price: totalPrice,
      deliveryType: _selectedDeliveryType,
      products: _orderedProducts,
      trackings: starterTrackings,
    );
    // await Future.delayed(const Duration(seconds: 2));
    return await ordersRepository
        .placeOrder(orderModel)
        .then((value) => true)
        .catchError((error, stackTrace) => false);
  }

  Future<void> placeOrder() async {
    setIsPlacingOrderLoading(true);

    await _placeOrder().then((orderPlaced) async {
      if (orderPlaced) {
        await Get.find<CartController>().clearCartProducts();
        Get.back();
        Get.snackbar("Success", "Order Placed Successfully");
      }
    });

    setIsPlacingOrderLoading(false);
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
