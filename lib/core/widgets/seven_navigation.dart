import 'package:flutter/material.dart';

import '../routing/navigation_config.dart';
import '../theme/app_theme.dart';

class SevenNavigation extends StatelessWidget {
  const SevenNavigation({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
  });
  final List<Category> items;
  final int selected;
  final ValueChanged<int> onSelect;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 8, 3, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(7, (i) {
            final active = i == selected;
            final isHome = i == 3;
            return Expanded(
              child: Semantics(
                selected: active,
                button: true,
                label: items[i].label,
                child: InkWell(
                  key: ValueKey('nav-$i'),
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => onSelect(i),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 64),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: isHome ? 46 : 32,
                          height: isHome ? 46 : 32,
                          decoration: BoxDecoration(
                            color: active
                                ? (isHome
                                      ? AppTheme.teal
                                      : const Color(0xFFE4F1EE))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              isHome ? 15 : 10,
                            ),
                          ),
                          child: Icon(
                            items[i].icon,
                            size: isHome ? 28 : 22,
                            color: active
                                ? (isHome ? Colors.white : AppTheme.teal)
                                : Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 27,
                          child: Center(
                            child: Text(
                              isHome ? 'Ana\nSayfa' : items[i].label,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 10,
                                height: 1.15,
                                fontWeight: active
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: active ? AppTheme.teal : Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ),
  );
}
