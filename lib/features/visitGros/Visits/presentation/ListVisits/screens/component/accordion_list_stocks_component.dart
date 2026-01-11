import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/functions/formatDate.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/buildSummaryRow.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AccordionListStocksComponent extends StatelessWidget {
  final List<dynamic> accordionSections;
  const AccordionListStocksComponent({ super.key, required this.accordionSections });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                  leading: Icon(Icons.add_business, color: Colors.black),
                  backgroundColor: ColorFile.codeColor,
                  collapsedBackgroundColor: ColorFile.greyBorderColor,
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  title: Text(
                      section['client']['fullName'],
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
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
                              const Text('Détail Stock', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 12),
                          buildSummaryRow('N°Document', section['documentno']),
                          buildSummaryRow('Date ', formatDate(section['dateOrdered'])),
                          const Divider(),
                          buildSummaryRow('Description', '${section['Description']}'),
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