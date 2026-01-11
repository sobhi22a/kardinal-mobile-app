import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:e_commerce_app/core/functions/static_values.dart';
import 'package:e_commerce_app/core/router/app_router.dart';
import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/widgets/default_button.dart';
import 'package:e_commerce_app/features/visitGros/Visits/domain/models/visit_response.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_bloc.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_state.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/buildSummaryRow.dart';
import 'package:e_commerce_app/localization/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ListVisitScreen extends StatefulWidget {
  const ListVisitScreen({super.key});

  @override
  State<ListVisitScreen> createState() => _ListVisitScreenState();
}

class _ListVisitScreenState extends State<ListVisitScreen> {
  VisitResponse visitResponse = VisitResponse(items: [], pageNumber: 0, pageSize: 0, totalCount: 0, totalPages: 0, hasPrevious: false, hasNext: false);

  final format = DateFormat("dd/MM/yyyy");
  late TextEditingController dateStartMission;

  @override
  void initState() {
    super.initState();

    // INITIAL DATE
    dateStartMission = TextEditingController(
      text: format.format(DateTime.now()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = VisitsBloc.get(context);
    final t = AppLocalizations(currentLanguage);

    return BlocConsumer<VisitsBloc, VisitsState>(
      listener: (context, state) {
        if (state is ListVisitsState) {
          setState(() {
            visitResponse = state.list;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Liste Visites'), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DateTimeField(
                        format: format,
                        controller: dateStartMission,
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          border: OutlineInputBorder(),
                        ),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            dateStartMission.text = format.format(date);
                          }
                          return date;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: defaultElevatedButton(
                        function: () => cubit.GetAllVisitsForUser(
                          visitDate: dateStartMission.text,
                        ),
                        text: '',
                        icon: Icons.downloading,
                        background: ColorFile.whiteColor,
                        iconColor: ColorFile.appColor,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: visitResponse.items.length,
                    itemBuilder: (context, index) {
                      final visit = visitResponse.items[index];

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text("Region: ${visit.regionName}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSummaryRow(t.text('visitor'), visit.visitorName),
                              buildSummaryRow(t.text('responsible'), visit.responsibleName),
                              buildSummaryRow(t.text('visit_date'), visit.visitDate),
                              buildSummaryRow(t.text('status'), visit.statusName),
                              const Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: defaultElevatedButton(function: () => GoRouter.of(context).push('${AppRouter.detailVisits}/${visit.id}'),
                                        text: '', icon: Icons.add_shopping_cart, fontSize: 20, background: ColorFile.appColor),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(child: defaultElevatedButton(function: () => GoRouter.of(context).push('${AppRouter.detailClientVisit}/${visit.id}'),
                                          text: "", icon: Icons.account_box_outlined, fontSize: 20, background: ColorFile.appColor)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: defaultElevatedButton(function: () => GoRouter.of(context).push('${AppRouter.detailStockVisit}/${visit.id}'),
                                          text: '', icon: Icons.add_chart_outlined, fontSize: 20, background: ColorFile.appColor)),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
