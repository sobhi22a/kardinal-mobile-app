import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_bloc.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_state.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/component/accordion_list_stocks_component.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/component/accordion_list_tiers_component.dart';
import 'package:e_commerce_app/features/visitGros/commons/models/Tiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListStockByVisitid extends StatelessWidget {
  final String visitId;
  ListStockByVisitid({super.key, required this.visitId});

  List<dynamic> stocks = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => VisitsBloc()..GetAllStockbyVisitId(visitId),
      child: BlocConsumer<VisitsBloc, VisitsState>(
        listener: (BuildContext context, VisitsState state) {
          if (state is ListStockByVisitIdState) {
            stocks = state.list;
            print(stocks);
          }
        },
        builder: (context, state) {
          VisitsBloc cubit = VisitsBloc.get(context);

          return Scaffold(
            appBar: AppBar(title: const Text('Stocks Clients')),
            body: Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: SingleChildScrollView(child: AccordionListStocksComponent(accordionSections: stocks)),
            ),
          );
        },
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text("$title:")),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}