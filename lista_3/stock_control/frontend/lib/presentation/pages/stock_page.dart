import 'package:flutter/material.dart';
import 'package:frontend/domain/entities/product.dart';
import 'package:frontend/domain/repositories/product_repository.dart';
import 'package:frontend/presentation/controllers/stock_controller.dart';
import 'package:frontend/presentation/widgets/product_form_dialog.dart';
import 'package:frontend/presentation/widgets/product_list_item.dart';
import 'package:frontend/presentation/widgets/stock_empty_state.dart';
import 'package:frontend/presentation/widgets/stock_summary_card.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key, required this.repository});

  final ProductRepository repository;

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late final StockController _controller;

  @override
  void initState() {
    super.initState();
    _controller = StockController(repository: widget.repository);
    _controller.addListener(_onControllerChanged);
    _controller.loadProducts();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) {
      return;
    }

    final message = _controller.errorMessage;
    if (message == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    _controller.clearError();
  }

  Future<void> _openCreateDialog() async {
    final result = await showDialog<ProductFormResult>(
      context: context,
      builder: (BuildContext context) => const ProductFormDialog(),
    );

    if (result == null) {
      return;
    }

    await _controller.addProduct(name: result.name, amount: result.amount);
  }

  Future<void> _openEditDialog(Product product) async {
    final result = await showDialog<ProductFormResult>(
      context: context,
      builder: (BuildContext context) => ProductFormDialog(product: product),
    );

    if (result == null) {
      return;
    }

    await _controller.saveProduct(
      id: product.id,
      name: result.name,
      amount: result.amount,
    );
  }

  Future<void> _confirmDelete(Product product) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete product'),
          content: Text('Delete ${product.name}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (approved != true) {
      return;
    }

    await _controller.removeProduct(product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Control'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: _controller.loadProducts,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateDialog,
        icon: const Icon(Icons.add),
        label: const Text('Product'),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final isWide = constraints.maxWidth >= 900;
              final listSection = _buildListSection();
              final summaryCard = StockSummaryCard(
                productCount: _controller.products.length,
                totalItems: _controller.totalItems,
              );

              if (isWide) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 340, child: summaryCard),
                      const SizedBox(width: 16),
                      Expanded(child: listSection),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    summaryCard,
                    const SizedBox(height: 12),
                    Expanded(child: listSection),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildListSection() {
    if (_controller.products.isEmpty) {
      return const StockEmptyState();
    }

    return Card(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _controller.products.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 8),
        itemBuilder: (BuildContext context, int index) {
          final product = _controller.products[index];
          return ProductListItem(
            product: product,
            onEdit: () => _openEditDialog(product),
            onDelete: () => _confirmDelete(product),
          );
        },
      ),
    );
  }
}
