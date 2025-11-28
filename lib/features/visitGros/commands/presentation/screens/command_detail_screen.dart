import 'package:e_commerce_app/core/functions/format_number.dart';
import 'package:e_commerce_app/database/models/command_line_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/commands_bloc.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/commands_state.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/accordion-command-detail-component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommandDetailScreen extends StatelessWidget {
  final String commandId;
  CommandDetailScreen({super.key, required this.commandId});

  List<CommandLine> commandLines = [];
  double commandTotalLine = 0;
  double commandLineTotalLine = 0;
  double grandTotal = 0;
  double discount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CommandsBloc()
        ..listDetailProdctByCommand(commandId)
        ..totalCommand(commandId),
      child: BlocConsumer<CommandsBloc, CommandsState>(
        listener: (BuildContext context, CommandsState state) {
          if (state is ListDetailProdctByCommandState) {
            commandLines = state.list;
          }
          if (state is TotalCommandState) {
            commandTotalLine = state.commandTotalLine;
            commandLineTotalLine = state.commandLineTotalLine;
            grandTotal = state.grandTotal;
            discount = state.discount;
          }
        },
        builder: (context, state) {
          CommandsBloc cubit = CommandsBloc.get(context);

          return Scaffold(
            appBar: AppBar(title: const Text('Détail de la commande')),
            body: Column(
              children: [
                Expanded(child: SingleChildScrollView(child: AccordionCommandDetailComponent(accordionSections: commandLines))),
                // fixed footer
                Container(
                  height: 80, // fixed height
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey.shade200, border: const Border(top: BorderSide(color: Colors.grey, width: 0.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total: ${formatNumber(commandTotalLine.toStringAsFixed(2))}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            'Remise: ${discount.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.redAccent, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Total général: ${formatNumber(grandTotal.toStringAsFixed(2))}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
