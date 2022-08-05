import 'package:ecommerce_getx/core/constant/constants.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/enums/delivery_type.dart';
import 'package:ecommerce_getx/data/model/card_model.dart';
import 'package:ecommerce_getx/data/model/shipping_address_model.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  // //? Pages
  // int _currentPage = 0;
  // int get pagesCurrentIndex => _currentPage;

  // final PageController pageController = PageController();

  // final List<Widget> pages = [
  //   const DelvieryPage(),
  //   const AddressPage(),
  //   const AddressPage(),
  //   const SummaryPage(),
  // ];

  // void changepagesCurrentIndex(int index) {
  //   _currentPage = index;
  //   update();
  // }

  // void nextPage() {
  //   if (_currentPage + 1 < pages.length) {
  //     changepagesCurrentIndex(_currentPage + 1);
  //     pageController.animateToPage(
  //       _currentPage,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.linear,
  //     );
  //   }
  // }

  // void prevPage() {
  //   changepagesCurrentIndex(_currentPage - 1);
  //   pageController.animateToPage(
  //     _currentPage,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.linear,
  //   );
  // }

  //? Delivery Type
  DeliveryType _selectedDeliveryType = DeliveryType.standard;
  DeliveryType get selectedDeliveryType => _selectedDeliveryType;

  changeDeliveryType(DeliveryType newDeliveryType) {
    _selectedDeliveryType = newDeliveryType;
    update();
  }

  //? Address

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

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
    await loadData();
    super.onInit();
  }
}
