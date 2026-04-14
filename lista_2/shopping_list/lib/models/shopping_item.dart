class ShoppingItem {
  String name;
  bool wasBought;

  ShoppingItem({
    required this.name,
    this.wasBought = false,
  });

  void toggleBought() {
    wasBought = !wasBought;
  }
}