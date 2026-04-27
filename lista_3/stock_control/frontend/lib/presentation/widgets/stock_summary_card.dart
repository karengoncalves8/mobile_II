import 'package:flutter/material.dart';

class StockSummaryCard extends StatelessWidget {
  const StockSummaryCard({
    super.key,
    required this.productCount,
    required this.totalItems,
  });

  final int productCount;
  final int totalItems;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Summary', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                Chip(
                  avatar: const Icon(Icons.inventory_2_outlined),
                  label: Text('Products: $productCount'),
                ),
                Chip(
                  avatar: const Icon(Icons.warehouse_outlined),
                  label: Text('Total items: $totalItems'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
