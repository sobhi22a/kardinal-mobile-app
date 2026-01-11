import 'package:e_commerce_app/core/functions/formatDate.dart';
import 'package:e_commerce_app/core/functions/format_number.dart';
import 'package:e_commerce_app/core/router/app_router.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_bloc.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailVisitScreen extends StatelessWidget {
  final String visitId;
  const DetailVisitScreen({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VisitsBloc()..GetAllCommandByVisitId(visitId),
      child: BlocConsumer<VisitsBloc, VisitsState>(
        listener: (_, __) {},
        builder: (context, state) {
          if (state is ListCommandByVisitState) {
            final commands = state.list;

            return Scaffold(
              appBar: AppBar(title: const Text("Détail Visite")),
              body: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: commands.length,
                itemBuilder: (context, index) {
                  final item = commands[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),

                      // ✅ FIXED TITLE (NO Expanded / Spacer)
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "#${item['documentno']}: ${item['client']['fullName']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (item['type'] == 0)
                            const Icon(Icons.remove_red_eye),
                        ],
                      ),

                      subtitle: Text("Statut : ${item['statusName']}"),

                      children: [
                        // ✅ ALWAYS wrap ExpansionTile children in Column(min)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // DATE + BUTTON
                            Row(
                              children: [
                                Expanded(
                                  child: rowWidget(
                                    "Date",
                                    formatDate(item['dateOrdered']),
                                  ),
                                ),
                                if (item['type'] != 0)
                                  IconButton(
                                    icon: const Icon(Icons.list_alt_rounded),
                                    onPressed: () {
                                      final id = item['id'];
                                      final clientName =
                                          item['client']['fullName'] ?? '';
                                      final encodedName =
                                      Uri.encodeComponent(clientName);

                                      context.push(
                                        "${AppRouter.detailCommandLine}/$id/$encodedName",
                                      );
                                    },
                                  ),
                              ],
                            ),

                            const SizedBox(height: 12),
                            const Divider(),
                            const SizedBox(height: 12),

                            // TOTALS
                            if (item['type'] == 0) ...[
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(item['description']?.toString() ?? '--'),
                            ] else ...[
                              rowWidget(
                                "Total ligne",
                                "${formatNumber(item['totalLine'].toString())} DA",
                              ),
                              rowWidget(
                                "Remise",
                                "${item['discount']}%",
                              ),
                              rowWidget(
                                "Total Général",
                                "${formatNumber(item['grandTotal'].toString())} DA",
                              ),
                            ],

                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),

                            // CLIENT
                            const Text(
                              "Client",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            rowWidget("Nom", item['client']['fullName']),
                            rowWidget("RC", item['client']['rc'] ?? '--'),
                            rowWidget("AI", item['client']['ai'] ?? '--'),
                            rowWidget("NIF", item['client']['nif'] ?? '--'),
                            rowWidget("NIS", item['client']['nis'] ?? '--'),
                            rowWidget(
                                "Localisation", item['client']['location']),
                            rowWidget(
                                "GPS", item['client']['locationGps'] ?? '--'),

                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),

                            // VISIT PLAN
                            const Text(
                              "Plan de visite",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            rowWidget("Visiteur",
                                item['visitPlan']['visitorName']),
                            rowWidget("Responsable",
                                item['visitPlan']['responsibleName']),
                            rowWidget("Région",
                                item['visitPlan']['regionName']),
                            rowWidget("Date visite",
                                item['visitPlan']['visitDate']),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(title: Text("Détail Visite")),
            body: SizedBox(),
          );
        },
      ),
    );
  }
}

Widget rowWidget(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            softWrap: true,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
