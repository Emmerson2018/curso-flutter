import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/finance_filter.dart';
import '../../providers/finance_providers.dart';

class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(financeFilterProvider);
    final controller = ref.read(financeFilterProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: controller.previousMonth,
                  icon: const Icon(Icons.chevron_left),
                  tooltip: 'Mês anterior',
                ),
                Expanded(
                  child: Text(
                    filters.month.label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: controller.nextMonth,
                  icon: const Icon(Icons.chevron_right),
                  tooltip: 'Próximo mês',
                ),
              ],
            ),
            const SizedBox(height: 8),
            SegmentedButton<TransactionKindFilter>(
              segments: TransactionKindFilter.values
                  .map(
                    (kind) => ButtonSegment<TransactionKindFilter>(
                      value: kind,
                      label: Text(kind.label),
                    ),
                  )
                  .toList(),
              selected: {filters.kind},
              onSelectionChanged: (selected) {
                controller.setKind(selected.first);
              },
            ),
          ],
        ),
      ),
    );
  }
}
