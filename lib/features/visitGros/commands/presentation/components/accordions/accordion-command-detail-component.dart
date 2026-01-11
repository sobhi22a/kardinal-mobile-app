import 'package:e_commerce_app/core/functions/format_number.dart';
import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/database/models/command_line_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/buildSummaryRow.dart';
import 'package:flutter/material.dart';

class AccordionCommandDetailComponent extends StatelessWidget {
  final List<CommandLine> accordionSections;
  const AccordionCommandDetailComponent({ super.key, required this.accordionSections });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                  leading: Icon(Icons.add_business),
                  backgroundColor: ColorFile.infoColor,
                  collapsedBackgroundColor: ColorFile.codeColor,
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  title: Column(
                    children: [
                      Text(section.productName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      const Divider(),
                      Row(
                        children: [
                          Text('Quantité: ${section.quantity}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text('ug: ${section.ug}%', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorFile.whiteColor, width: 1),
                        color: ColorFile.whiteColor,
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          const Text('Détails du produit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                          const SizedBox(height: 12),
                          buildSummaryRow('Prix', '${formatNumber(section.price.toString())}'),
                          buildSummaryRow('Quantité', '${section.quantity}'),
                          buildSummaryRow('ug', '${section.ug}%'),
                          buildSummaryRow('Quantité total', '${formatNumber(section.totalQuantity.toString())}'),
                          buildSummaryRow('Description', section.description),
                          const Divider(),
                          buildSummaryRow('Total', '${formatNumber(section.totalLine.toStringAsFixed(2))} DZD', isTotal: true),
                          const Divider(),
                        ],
                      ),
                    ),
                  ],
                )
            );
          },
        ),
      ],
    ));
  }
}