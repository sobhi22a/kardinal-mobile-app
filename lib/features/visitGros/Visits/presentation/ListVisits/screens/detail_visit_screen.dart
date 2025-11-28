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
  DetailVisitScreen({super.key, required this.visitId});

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
              appBar: AppBar(title: Text("Détail Visite")),
              body: ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: commands.length,
                itemBuilder: (context, index) {
                  final item = commands[index];

                  return Card(
                    margin: EdgeInsets.only(bottom: 14),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Expanded(flex: 5, child: Text(
                            "#${item['documentno']}: ${item['client']['fullName']}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          const Spacer(),
                          item['type'] == 0 ? Icon(Icons.remove_red_eye) : SizedBox(),
                        ],
                      ),
                      subtitle: Text("Statut : ${item['statusName']}"),
                      childrenPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 10),

                      children: [
                        // DATE
                        Row(
                          children: [
                            rowWidget("", formatDate(item['dateOrdered'])),
                            const Spacer(),
                            item['type'] == 0 ? SizedBox()
                                : IconButton(
                                onPressed: () {
                                  final id = commands[index]['id'];
                                  final clientName = item['client']['fullName'] ?? '';
                                  final encodedName = Uri.encodeComponent(clientName);

                                  GoRouter.of(context).push("${AppRouter.detailCommandLine}/$id/$encodedName");
                                }, icon: Icon(Icons.list_alt_rounded))
                          ],
                        ),
                        SizedBox(height: 12),
                        Divider(),
                        SizedBox(height: 12),

                        // TOTALS
                        item['type'] == 0
                            ? Column(
                                children: [
                                  Text('Description', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                  Text(item['description'].toString()),
                                ],
                              )
                            : Column(
                                children: [
                                  rowWidget("Total ligne", "${formatNumber(item['totalLine'].toString())} DA"),
                                  rowWidget("Remise", "${item['discount']}%"),
                                  rowWidget("Total Général", "${formatNumber(item['grandTotal'].toString())} DA"),
                                ],
                              ),

                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),

                        // CLIENT SECTION
                        Text("Client",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        rowWidget("Nom", item['client']['fullName']),
                        rowWidget("RC", item['client']['rc']),
                        rowWidget("AI", item['client']['ai']),
                        rowWidget("NIF", item['client']['nif']),
                        rowWidget("NIS", item['client']['nis']),
                        rowWidget("Localisation", item['client']['location']),
                        rowWidget("GPS", item['client']['locationGps']),

                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),

                        // VISIT PLAN SECTION
                        Text("Plan de visite", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        rowWidget("Visiteur", item['visitPlan']['visitorName']),
                        rowWidget("Responsable", item['visitPlan']['responsibleName']),
                        rowWidget("Région", item['visitPlan']['regionName']),
                        rowWidget("Date visite", item['visitPlan']['visitDate']),

                        SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          /// NO loading, no spinner, just empty UI until data arrives
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
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            )),
        Text(
          value,
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.right,
        ),
      ],
    ),
  );
}



