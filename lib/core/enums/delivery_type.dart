enum DeliveryType {
  standard(10),
  nextDay(20);

  const DeliveryType(this.price);
  final double price;
}
