import 'package:e_commerce_app/core/functions/format_number.dart';
import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/functions/formatDate.dart';
import 'package:e_commerce_app/core/widgets/default_button.dart';
import 'package:e_commerce_app/database/models/command_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/buildSummaryRow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccordionCommandComponent extends StatelessWidget {
  final List<Command> accordionSections;
  const AccordionCommandComponent({ super.key, required this.accordionSections });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Orders', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: accordionSections.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final section = accordionSections[index];
            return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ExpansionTile(
                  leading: Icon(Icons.add_business, color: section.status == 2 ? Colors.green : Colors.black),
                  backgroundColor: ColorFile.codeColor,
                  collapsedBackgroundColor: ColorFile.greyBorderColor,
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  title: Row(
                    children: [
                      Text(
                          section.clientName,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                      ),
                      const Spacer(),
                      section.type == 0 ? Icon(Icons.visibility_rounded) : SizedBox()
                    ],
                  ),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorFile.whiteColor, width: 1),
                        color: ColorFile.whiteColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('Résumé de Commande', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                              const Spacer(),
                              Material(
                                color: Colors.white,
                                child: Center(
                                  child: Ink(
                                    decoration: ShapeDecoration(color: ColorFile.appColor, shape: CircleBorder(),
                                        shadows: [BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6,
                                            offset: Offset(0, 2),)]
                                    ),
                                    child: IconButton(icon: const Icon(Icons.list_alt_rounded), color: Colors.white,
                                      onPressed: () => GoRouter.of(context).push('/detailCommand/${section.id}'),
                                      tooltip: 'Details de la command',),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          buildSummaryRow('Date', formatDate(section.dateOrdered)),
                          buildSummaryRow('Status', '${section.status}'),
                          buildSummaryRow('montant', '${formatNumber(section.totalLine.toString())} DZD'),
                          buildSummaryRow('Remise', '${section.discount}%'),
                          const Divider(),
                          buildSummaryRow('Total avec remise', '${formatNumber(section.grandTotal.toString())} DZD', isTotal: true),
                          const Divider(),
                          section.status == 1 ?
                          defaultButton (
                              function: () => GoRouter.of(context).push('/commandLine/${section.id}'),
                              text: 'Ajouter une ligne de produit'
                          ) : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                )
            );
            },
        ),
      ],
    );
  }
}