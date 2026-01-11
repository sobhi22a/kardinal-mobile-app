import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/stock_bloc.dart';
import 'package:e_commerce_app/localization/AppLocalizations.dart';
import 'package:flutter/material.dart';

Widget buildDeleteAllFooter(
    BuildContext context,
    StockBloc cubit,
    AppLocalizations t,
    ) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, -3),
        ),
      ],
    ),
    child: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => showDeleteAllConfirmation(context, cubit, t),
          icon: const Icon(Icons.delete_sweep),
          label: Text(t.text('delete_all_stocks')),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    ),
  );
}

void showDeleteAllConfirmation(
    BuildContext context,
    StockBloc cubit,
    AppLocalizations t,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning, color: Colors.orange[700]),
          const SizedBox(width: 10),
          Expanded(child: Text(t.text('confirm_deletion'))),
        ],
      ),
      content: Text(
        t.text('confirm_message'),
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(t.text('cancel')),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(dialogContext).pop();
            await cubit.deleteAllStocks();
            await cubit.deleteAllStockLines();
            cubit.getVisitByDate();
            cubit.getListOfStocks();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(t.text('ok')),
        ),
      ],
    ),
  );
}