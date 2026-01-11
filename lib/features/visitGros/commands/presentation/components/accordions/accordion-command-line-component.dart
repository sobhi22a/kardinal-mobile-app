import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/widgets/alert-dialog.dart';
import 'package:e_commerce_app/database/models/command_line_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/commands_bloc.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/buildSummaryRow.dart';
import 'package:flutter/material.dart';

class AccordionCommandLineComponent extends StatelessWidget {
  final List<CommandLine> accordionSections;
  const AccordionCommandLineComponent({ super.key, required this.accordionSections });

  @override
  Widget build(BuildContext context) {
    CommandsBloc cubit = CommandsBloc.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Liste des produits commandés', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Accordion(
          maxOpenSections: 2,
          headerBackgroundColorOpened: Colors.black54,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: accordionSections.map((section) {
            return AccordionSection(
              isOpen: false,
              leftIcon: Icon(Icons.add_business, color: Colors.white),
              headerBackgroundColor: ColorFile.appText,
              headerBackgroundColorOpened: (ColorFile.appColor).withOpacity(0.8),
              header: Text(section.productName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child:Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Résumé de la Ligne', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                        IconButton(onPressed: () => genericAlertDialog(context: context, title: 'Supprimer la ligne', text: 'Voulez vous supprimer cette ligne ?',
                            function: ()=>cubit.removeLineCommand(section.id, section.commandId)),
                            icon: Icon(Icons.delete_forever_outlined, color: Colors.red.shade900))
                      ],
                    ),
                    const SizedBox(height: 12),
                    buildSummaryRow('Prix Unitaire', '${section.price.toStringAsFixed(2)} DZD'),
                    buildSummaryRow('Quantité', '${section.quantity} unités'),
                    buildSummaryRow('ug', '${section.ug}%'),
                    buildSummaryRow('Quantité Total', '${section.totalQuantity} unités'),
                    const Divider(),
                    buildSummaryRow('Total Ligne', '${section.totalLine.toStringAsFixed(2)} DZD', isTotal: true),
                  ],
                )
              ),
              contentHorizontalPadding: 20,
              contentBorderWidth: 1,
              contentBorderColor: ColorFile.appColor,
            );
          }).toList(),
        ),
      ],
    );
  }
}
