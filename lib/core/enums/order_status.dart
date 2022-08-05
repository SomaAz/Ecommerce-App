enum OrderStatus {
  processing("processing"),
  delivered("delivered"),
  canceld("canceld");

  const OrderStatus(this.name);
  final String name;
}
