enum Category {
  eletronics,
  clothing,
  home,
  food,
  acessories;

  String get name {
    switch (this) {
      case Category.eletronics:
        return 'Eletrônicos';
      case Category.clothing:
        return 'Roupas';
      case Category.home:
        return 'Casa';
      case Category.food:
        return 'Alimentos';
      case Category.acessories:
        return 'Acessórios';
    }
  }
}