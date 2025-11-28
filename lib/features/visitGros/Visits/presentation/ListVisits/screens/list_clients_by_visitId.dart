import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_bloc.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_state.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/component/accordion_list_tiers_component.dart';
import 'package:e_commerce_app/features/visitGros/commons/models/Tiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListClientsByVisitid extends StatelessWidget {
  final String regionId;
  ListClientsByVisitid({super.key, required this.regionId});

  List<Tier> tiers = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => VisitsBloc()..GetAllClientsByRegionIdAndGroup(regionId),
      child: BlocConsumer<VisitsBloc, VisitsState>(
        listener: (BuildContext context, VisitsState state) {
          if (state is ListClientsByRegionIdAndGroupState) tiers = state.list;
        },
        builder: (context, state) {
          VisitsBloc cubit = VisitsBloc.get(context);

          return Scaffold(
            appBar: AppBar(title: const Text('Clients de la region')),
            body: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: AccordionListTiersComponent(accordionSections: tiers),
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