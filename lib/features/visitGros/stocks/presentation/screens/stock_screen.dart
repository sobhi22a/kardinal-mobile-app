import 'package:e_commerce_app/core/functions/static_values.dart';
import 'package:e_commerce_app/database/models/stock_model.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/stock_bloc.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/stock_state.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/component/accordion_stock_component.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/component/stock_form_dialog.dart';
import 'package:e_commerce_app/localization/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {

  // State Variables (persist when navigating back)
  List<Map<String, dynamic>> clients = [];
  Map<String, dynamic> visitPlanToday = {};
  List<Stock> listStocks = [];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(currentLanguage);
    final cubit = context.read<StockBloc>();

    return BlocConsumer<StockBloc, StockState>(
      listener: _handleStateChanges,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(t.text('Stock')),
            centerTitle: true,
          ),
          body: _buildBody(context, state, t),
        );
      },
    );
  }

  // LISTENER
  void _handleStateChanges(BuildContext context, StockState state) {
    final cubit = context.read<StockBloc>();

    setState(() {
      if (state is VisitPlanTodayStockState) {
        visitPlanToday = state.data;
      }

      if (state is ListCliensStockState) {
        clients = state.list;
      }

      if (state is ListStocksState) {
        listStocks = state.list;
      }

      if (state is StockCreatedSuccessState) {
        if (state.isCreated == true) {
          GoRouter.of(context).push('/stockLine/${state.id}');
          cubit.getListOfStocks();
        }
      }
    });
  }

  // BODY
  Widget _buildBody(BuildContext context, StockState state, AppLocalizations t) {
    final cubit = context.read<StockBloc>();

    return Column(
      children: [
        _buildVisitInfoCard(visitPlanToday, t, context, cubit, clients),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: AccordionStockComponent(accordionSections: listStocks),
            ),
          ),
        ),
      ],
    );
  }

  // CARD UI
  Widget _buildVisitInfoCard(
      Map<String, dynamic> visitPlanToday,
      AppLocalizations t,
      BuildContext context,
      StockBloc cubit,
      List<Map<String, dynamic>> clients,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // First row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip(
                    icon: Icons.location_on,
                    label: t.text('region'),
                    value: visitPlanToday['regionName'] ?? '',
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 20),
                  _buildChip(
                    icon: Icons.calendar_today,
                    label: t.text('date'),
                    value: visitPlanToday['visitDate'] ?? '',
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Responsable
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildChip(
                icon: Icons.supervised_user_circle,
                label: t.text('responsable'),
                value: visitPlanToday['responsibleName'] ?? '',
                color: Colors.purple,
              ),
            ),

            const SizedBox(height: 20),

            // Button
            ElevatedButton.icon(
              onPressed: () => _showStockFormDialog(
                context,
                cubit,
                clients,
                visitPlanToday,
              ),
              icon: const Icon(Icons.add),
              label: Text(t.text('create_new_stock')),
            ),
          ],
        ),
      ),
    );
  }

  // CHIP
  Widget _buildChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // OPEN DIALOG
  void _showStockFormDialog(
      BuildContext context,
      StockBloc cubit,
      List<Map<String, dynamic>> clients,
      Map<String, dynamic> visitPlanToday,
      ) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: StockFormDialog(
          clients: clients,
          visitPlanToday: visitPlanToday,
          cubit: cubit,
        ),
      ),
    );
  }
}

