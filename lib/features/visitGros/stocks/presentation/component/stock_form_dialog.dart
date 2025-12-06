import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/stock_bloc.dart';
import 'package:flutter/material.dart';

class StockFormDialog extends StatefulWidget {
  final List<Map<String, dynamic>> clients;
  final Map<String, dynamic> visitPlanToday;
  final StockBloc cubit;

  const StockFormDialog({
    super.key,
    required this.clients,
    required this.visitPlanToday,
    required this.cubit,
  });

  @override
  State<StockFormDialog> createState() => _StockFormDialogState();
}

class _StockFormDialogState extends State<StockFormDialog> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic>? selectedClient;
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TITLE
              Text(
                "Create Stock",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // CLIENT DROPDOWN
              DropdownButtonFormField<Map<String, dynamic>>(
                decoration: const InputDecoration(
                  labelText: "Select Client",
                  border: OutlineInputBorder(),
                ),
                items: widget.clients
                    .map(
                      (client) => DropdownMenuItem(
                    value: client,
                    child: Text(client['label'] ?? ''),
                  ),
                )
                    .toList(),
                value: selectedClient,
                onChanged: (value) {
                  setState(() => selectedClient = value);
                },
                validator: (value) =>
                value == null ? "Client is required" : null,
              ),

              const SizedBox(height: 20),

              // DESCRIPTION FIELD
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 20),

              // SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.cubit.createStock(
        client: selectedClient,
        visitPlanId: widget.visitPlanToday['id'],
        description: descriptionController.text.trim(),
      );

      Navigator.pop(context); // Close dialog
    }
  }
}