import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/presentation/molecules/menu_item_card.dart';

class MenuGridItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuGridItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class MenuGrid extends StatelessWidget {
  final List<MenuGridItem> items;

  const MenuGrid({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppDimensions.paddingMedium,
      crossAxisSpacing: AppDimensions.paddingMedium,
      children: items
          .map(
            (item) => MenuItemCard(
              icon: item.icon,
              label: item.label,
              onTap: item.onTap,
            ),
          )
          .toList(),
    );
  }
}
