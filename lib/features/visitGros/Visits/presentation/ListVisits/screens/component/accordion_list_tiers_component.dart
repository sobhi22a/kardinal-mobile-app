import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/functions/formatDate.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/buildSummaryRow.dart';
import 'package:e_commerce_app/features/visitGros/commons/models/Tiers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

class AccordionListTiersComponent extends StatelessWidget {
  final List<Tier> accordionSections;
  const AccordionListTiersComponent({ super.key, required this.accordionSections });

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
                      section.fullName,
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
                              const Text('Détail Client', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
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
                                    child: Link(uri: Uri.parse(section.urlGps),
                                        builder: (context, openLink) => IconButton(onPressed: openLink, color: Colors.white, icon: const Icon(Icons.location_on))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          buildSummaryRow('Premier Commande', formatDate(section.firstSale.toString())),
                          buildSummaryRow('Groupe de Client', '${section.groupTier}'),
                          buildSummaryRow('Status Credit Client', '${section.statusCreditTier}'),
                          buildSummaryRow('RC', section.rc),
                          buildSummaryRow('AI', section.ai),
                          buildSummaryRow('NIF', section.nif),
                          buildSummaryRow('NIS', section.nis),
                          buildSummaryRow('Adresse', section.location),
                          buildSummaryRow('Adresse GPS', section.locationGps),
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