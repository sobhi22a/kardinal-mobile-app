import 'package:e_commerce_app/core/functions/format_number.dart';
import 'package:e_commerce_app/features/visitGros/Visits/domain/models/detail_command_lines.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_bloc.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_state.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/detail_visit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCommandLinesProductScreen extends StatelessWidget {

  final String commandId;
  final String clientName;

  DetailCommandLinesProductScreen({super.key, required this.commandId, required this.clientName});

  CommandLinesResponse lines = CommandLinesResponse(commandLines: [], totalLines: 0);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => VisitsBloc()..GetCommandByCommandId(commandId),
      child: BlocConsumer<VisitsBloc, VisitsState>(
        listener: (BuildContext context, VisitsState state) {
            if(state is ListCommandLineByCommandIdState)  {
              lines = state.list;
            }
        },
        builder: (context, state) {
          VisitsBloc cubit = VisitsBloc.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Lignes de commande'),
              centerTitle: true,
            ),

            body: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 2,
                  child: Container(
                    width: double.infinity, // makes the card full width
                    padding: const EdgeInsets.all(16), // optional padding inside the card
                    child: Text(
                      clientName.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                // ----------- Scrollable List -----------
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: lines.commandLines.map((line) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  line.productName,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(),

                              rowWidget("Quantité", "${line.quantity}"),
                              rowWidget("Bonus", "${line.bonus}%"),
                              rowWidget("Total Quantité", "${line.totalQuantity}"),
                              rowWidget("Prix", "${formatNumber(line.price.toString())} DA"),
                              rowWidget("Total Ligne", "${formatNumber(line.totalLine.toString())} DA"),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // ----------- FIXED FOOTER -----------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border(top: BorderSide(color: Colors.blue.shade200)),
                  ),
                  child: Text(
                    "Total des lignes : ${formatNumber(lines.totalLines.toString())} DA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
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