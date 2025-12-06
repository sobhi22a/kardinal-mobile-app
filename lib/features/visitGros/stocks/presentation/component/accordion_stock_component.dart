import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/functions/formatDate.dart';
import 'package:e_commerce_app/database/models/stock_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/buildSummaryRow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccordionStockComponent extends StatelessWidget {
  final List<Stock> accordionSections;
  const AccordionStockComponent({ super.key, required this.accordionSections });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Clients', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                  backgroundColor: ColorFile.codeColor,
                  collapsedBackgroundColor: ColorFile.greyBorderColor,
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  title: Text(
                      section.clientName,
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
                              const Text('Résumé de stock', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                              const Spacer(),
                              Material(
                                color: Colors.white,
                                child: Center(
                                  child: Ink(
                                    decoration: ShapeDecoration(color: ColorFile.appColor, shape: CircleBorder(),
                                    shadows: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2),)]),
                                    child: IconButton(icon: const Icon(Icons.list_alt_rounded), color: Colors.white,
                                      onPressed: () => GoRouter.of(context).push('/stockLine/${section.id}'),
                                      tooltip: 'Details de la command',),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          buildSummaryRow('Date', formatDate(section.dateOrdered)),
                          buildSummaryRow('description', section.description),
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