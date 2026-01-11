import 'package:e_commerce_app/core/functions/format_number.dart';
import 'package:e_commerce_app/core/functions/static_values.dart';
import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/widgets/default_button.dart';
import 'package:e_commerce_app/database/models/Stock_line_model.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/stock_bloc.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/stock_state.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/sync_functions.dart';
import 'package:e_commerce_app/localization/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';

class StockLineScreen extends StatefulWidget {
  final String stockId;

  const StockLineScreen({
    super.key,
    required this.stockId,
  });

  @override
  State<StockLineScreen> createState() => _StockLineScreenState();
}

class _StockLineScreenState extends State<StockLineScreen> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> products = [];
  List<StockLine> stockLines = [];
  double grandTotal = 0.0;
  Map<String, dynamic>? selectedProduct;

  // FORM CONTROLLER
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      selectedProduct = null;
      _productController.clear();   // ✅ RESET LABEL TEXT
    });

    _quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockBloc()
        ..getListProducts()
        ..getListOfStockLinesbyStockId(widget.stockId),
      child: BlocConsumer<StockBloc, StockState>(
        listener: (context, state) {
          if (state is StockProductsLoadedStockState) {
            products = state.products;
          }
          if (state is ListStockLinesByStockIdState) {
            stockLines = state.list;
            grandTotal = state.grandTotal;
          }
        },
        builder: (context, state) {
          final t = AppLocalizations(currentLanguage);
          final cubit = StockBloc.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(t.text('stock_line')),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _resetForm,
                )
              ],
            ),

            body: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Card(
                    elevation: 4,
                      child: Padding(
                          padding: EdgeInsetsGeometry.all(10),
                         child: Column(
                           children: [
                             EasyAutocomplete(
                               controller: _productController,   // REQUIRED to avoid the error
                               suggestions: products.map((p) => p['name'].toString()).toList(),
                               onChanged: (value) {},
                               onSubmitted: (value) {
                                 final found = products.firstWhere((p) => p['name'] == value, orElse: () => {});
                                 if (found.isNotEmpty) { setState(() => selectedProduct = found); }
                               },

                               validator: (value) {
                                 if (value == null || value.isEmpty || selectedProduct == null) { return "Select a product"; }
                                 return null;
                               },
                               decoration: const InputDecoration(labelText: "Product", border: OutlineInputBorder()),
                             ),
                             const SizedBox(height: 20),
                             // QUANTITY
                             TextFormField(
                               controller: _quantityController,
                               keyboardType: TextInputType.number,
                               decoration: const InputDecoration(
                                 labelText: "Quantity",
                                 border: OutlineInputBorder(),
                                 prefixIcon: Icon(Icons.format_list_numbered),
                               ),
                               validator: (value) {
                                 if (value == null || value.isEmpty) { return "Enter quantity"; }
                                 final q = double.tryParse(value);
                                 if (q == null || q <= 0) { return "Invalid quantity"; }
                                 return null;
                               },
                             ),
                             const SizedBox(height: 30),
                             // ADD BUTTON
                             SizedBox(
                               width: double.infinity,
                               child: ElevatedButton.icon(
                                 onPressed: () {
                                   if (_formKey.currentState!.validate()) { _submitStockLine(cubit); }
                                 },
                                 icon: const Icon(Icons.add),
                                 label: Text(t.text('add_stock_line')),
                               ),
                             ),
                           ],
                         ),
                      )
                  ),
                ),
                const Divider(),
                Expanded(
                    flex: 6,
                    child:  SingleChildScrollView(
                    child:  Column(
                     children: stockLines.map((line) {
                       return Card(
                         child: ListTile(
                            title: Text(line.productName),
                            subtitle: Row(
                              children: [
                                // Text("Total: ${formatNumber(line.totalLine.toString())}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(),
                                const Spacer(),
                                Text("Qty: ${line.quantity}", style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                         ),
                       );
                     }).toList(),
                   )
               )),
                // ----------- FIXED FOOTER -----------
                Expanded(flex: 1, child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border(top: BorderSide(color: Colors.blue.shade200)),
                  ),
                  child: Row(
                    children: [
                      // Text("Total: ${formatNumber(grandTotal.toString())}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(),
                      const Spacer(),
                      Expanded(flex: 3, child: defaultElevatedButton(
                          function: () async {
                            await syncStocks();
                          },
                          text: 'Valider stock', icon: Icons.check, background: ColorFile.completeColor
                      )),
                    ],
                  ),
                ),)
              ],
            ),
          );
        },
      ),
    );
  }

  void _submitStockLine(StockBloc cubit) {
    final quantity = double.parse(_quantityController.text);
    final lineData = {
      "stockId": widget.stockId,
      "productId": selectedProduct!['id'],
      "productName": selectedProduct!['name'],
      "price": selectedProduct!['price'],
      "quantity": quantity,
    };

    cubit.createStockLine(lineData);

    _resetForm();
  }
}
