import 'package:e_commerce_app/core/functions/static_values.dart';
import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/widgets/default_button.dart';
import 'package:e_commerce_app/database/models/command_line_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/commands_bloc.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/commands_state.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/accordion-command-line-component.dart';
import 'package:e_commerce_app/localization/AppLocalizations.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommandLineScreen extends StatefulWidget {
  final String commandId;

  const CommandLineScreen({super.key, required this.commandId});

  @override
  State<CommandLineScreen> createState() => _CommandLineScreenState();
}

class _CommandLineScreenState extends State<CommandLineScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> products = [];
  List<CommandLine> commandLines = [];
  Map<String, dynamic>? selectedProduct;

  // Form controllers
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _ugController = TextEditingController(text: '0');
  final TextEditingController _totalQuantityController = TextEditingController(text: '0');
  final TextEditingController _totalLineController = TextEditingController(text: '0.00');
  final TextEditingController _productController = TextEditingController();


  // Variables for calculation
  double _unitPrice = 0.0;
  double _productug = 0.0;

  @override
  void initState() {
    super.initState();
    // Add listeners to recalculate when quantity or ug changes

    _quantityController.addListener(_calculateTotals);
    _ugController.addListener(_calculateTotals);
  }

  @override
  void dispose() {
    _productController.dispose();
    _quantityController.dispose();
    _ugController.dispose();
    _totalQuantityController.dispose();
    _totalLineController.dispose();
    super.dispose();
  }

  void _calculateTotals() {
    if (selectedProduct == null) return;
    try {
      final quantity = double.tryParse(_quantityController.text) ?? 0.0;
      final ug = double.tryParse(_ugController.text) ?? 0.0;

      // Calculate total quantity = quantity + ug
      final totalQuantity = quantity * (ug / 100 + 1);

      // Calculate total line = quantity * unit price
      final totalLine = quantity * _unitPrice;

      // Update controllers
      _totalQuantityController.text = totalQuantity.toStringAsFixed(2);
      _totalLineController.text = totalLine.toStringAsFixed(2);

      setState(() {}); // Trigger UI update
    } catch (e) {
      _totalQuantityController.text = '0.00';
      _totalLineController.text = '0.00';
    }
  }

  void _onProductSelected(Map<String, dynamic> product) {
    setState(() {
      selectedProduct = product;
      _unitPrice = double.tryParse(product['price']?.toString() ?? '0') ?? 0.0;

      // Get ug from product data
      _productug = double.tryParse(product['ug']?.toString() ?? product['ugQuantity']?.toString() ?? product['defaultug']?.toString() ?? '0'
      ) ?? 0.0;
      print('_productug $_productug ${product['ug']}');
      // Auto-set ug value from product
      _ugController.text = _productug.toStringAsFixed(2);
    });
    _calculateTotals();
  }

  void _resetForm() {

    setState(() {
      selectedProduct = null;
      _productController.clear();
      _unitPrice = 0.0;
      _productug = 0.0;
    });
    _quantityController.clear();
    _ugController.text = '0';
    _totalQuantityController.text = '0';
    _totalLineController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(currentLanguage);
    return BlocProvider(
      create: (BuildContext context) => CommandsBloc()..getListProducts()..getListOfCommandLinesbyCommandId(widget.commandId),
      child: BlocConsumer<CommandsBloc, CommandsState>(
        listener: (BuildContext context, CommandsState state) {
          if (state is ListProductsState) {
            setState(() {
              products = state.list;
              print(products);
            });
          }

          if (state is ListCommandLinesByCommandState) {
            setState(() {
              commandLines = state.list;
            });
          }
        },
        builder: (context, state) {
          CommandsBloc cubit = CommandsBloc.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(t.text('command_line')),
              actions: [
                IconButton(
                  icon: const Icon(Icons.clear_all),
                  onPressed: _resetForm,
                  tooltip: 'Reset Form',
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Product Selection
                      EasyAutocomplete(
                        controller: _productController,
                        suggestions: products.map((product) => product['label'].toString()).toList(),
                        onChanged: (value) => print('Selected: $value'),
                        onSubmitted: (value) {
                          var selectedProductData = products.firstWhere((product) => product['label'] == value, orElse: () => {});
                          if (selectedProductData.isNotEmpty) {
                            _onProductSelected(selectedProductData);
                            print('Submitted - Value: ${selectedProductData['value']}, Label: ${selectedProductData['label']}');
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty || selectedProduct == null) {
                            return 'Veuillez sélectionner un produit';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Produits',
                          hintText: 'Rechercher un produit...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Selected Product Info
                      if (selectedProduct != null) ...[
                        Card(
                          color: Colors.blue[50],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Prix unitaire: ${_unitPrice.toStringAsFixed(2)} DZD'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                      Row(
                        children: [
                          Expanded(child: TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Quantité',
                              hintText: 'Entrez la quantité',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.format_list_numbered),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer la quantité';
                              }
                              final quantity = double.tryParse(value);
                              if (quantity == null || quantity <= 0) {
                                return 'Quantité invalide';
                              }
                              return null;
                            },
                          )),
                          const SizedBox(width: 16),
                          // ug Field
                          Expanded(child: TextFormField(
                            controller: _ugController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'ug',
                              hintText: 'Quantité ug',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.card_giftcard),
                              suffixIcon: _productug > 0
                                  ? Tooltip(
                                message: 'ug automatique défini pour ce produit',
                                child: Icon(
                                  Icons.auto_awesome,
                                  color: Colors.orange.shade700,
                                ),
                              )
                                  : null,
                            ),
                            validator: (value) {
                              final ug = double.tryParse(value ?? '0');
                              if (ug == null || ug < 0) {
                                return 'ug invalide';
                              }
                              return null;
                            },
                          )),
                        ],
                      ),
                      // Quantity Field
                      const SizedBox(height: 20),
                      // Total Quantity Display (Read-only)
                      Row(
                        children: [
                          Expanded(child: TextFormField(
                            controller: _totalQuantityController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Quantité Totale (Quantité + ug)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.shopping_cart),
                              suffixText: 'unités',
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          )),
                          const SizedBox(width: 16),
                          // Total Line Field (Read-only)
                          Expanded(child: TextFormField(
                            controller: _totalLineController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Total Ligne (Quantité × Prix)',
                              hintText: '0.00',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calculate),
                              suffixText: 'DZD',
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _submitCommandLine(cubit);
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Ajouter Ligne de Commande'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Fixed: Remove the nested SingleChildScrollView
                      AccordionCommandLineComponent(accordionSections: commandLines),
                      const Divider(),
                      defaultElevatedButton(function: () => cubit.validCommand(context, widget.commandId), text: 'Valider la commande', icon: Icons.check, background: ColorFile.completeColor)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  void _submitCommandLine(CommandsBloc cubit) {
    if (selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner un produit')),
      );
      return;
    }

    final quantity = double.parse(_quantityController.text);
    final ug = double.parse(_ugController.text);
    final totalQuantity = quantity * (ug / 100 + 1);
    final totalLine = quantity * _unitPrice;

    // Prepare command line data
    final commandLineData = {
      'commandId': widget.commandId,
      'productId': selectedProduct!['value'],
      'productName': selectedProduct!['label'],
      'quantity': quantity,
      'ug': ug,
      'totalQuantity': totalQuantity,
      'price': _unitPrice,
      'totalLine': totalLine,
      'description': '',
    };

    cubit.createCommandLine(commandLineData);

    _resetForm();
  }
}