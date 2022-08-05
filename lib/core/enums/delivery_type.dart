enum DeliveryType {
  standard(10, "standard"),
  nextDay(20, "nextDay");

  const DeliveryType(this.price, this.name);
  final double price;
  final String name;
}
