import 'package:flutter/material.dart';
import 'package:products_catalog/enums/category.dart';
import 'package:products_catalog/models/Product.dart';
import 'package:products_catalog/widget/new_product_form.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<Product> products = [];
  List<Product> filteredProducts = [];

  Category? selectedCategory;
  late final TabController _tabController;

  List<Product> filterByCategory(Category? category) {
    if (category == null) {
      return products;
    }
    return products.where((product) => product.category == category).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_handleTabChange);
    selectedCategory = _tabCategories[_tabController.index];
    filteredProducts = filterByCategory(null);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  List<Tab> tabs = [
    Tab(text: 'Todos', icon: Icon(Icons.inventory_2)),
    Tab(text: Category.eletronics.name, icon: Icon(Icons.electrical_services)),
    Tab(text: Category.clothing.name, icon: Icon(Icons.checkroom)),
    Tab(text: Category.home.name, icon: Icon(Icons.home)),
    Tab(text: Category.food.name, icon: Icon(Icons.fastfood)),
    Tab(text: Category.acessories.name, icon: Icon(Icons.watch)),
  ];

  final List<Category?> _tabCategories = [
    null,
    Category.eletronics,
    Category.clothing,
    Category.home,
    Category.food,
    Category.acessories,
  ];

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      return;
    }

    final category = _tabCategories[_tabController.index];
    setState(() {
      selectedCategory = category;
      filteredProducts = filterByCategory(selectedCategory);
    });
  }

  void openModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(0),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                child: NewProductForm(
                  onProductAdded: (product) {
                    setState(() {
                      products.add(product);
                      filteredProducts = filterByCategory(selectedCategory);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        bottom: TabBar(controller: _tabController, tabs: tabs),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TabBarView(
          controller: _tabController,
          children: _tabCategories
              .map(
                (category) {
                  final visibleProducts = filterByCategory(category);
                  return ListView.builder(
                    itemCount: visibleProducts.length,
                    itemBuilder: (context, index) {
                      final product = visibleProducts[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                      );
                    },
                  );
                },
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
