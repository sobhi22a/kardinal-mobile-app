import 'package:e_commerce_app/components/cards/card_home_icon.dart';
import 'package:e_commerce_app/core/functions/static_values.dart';
import 'package:e_commerce_app/core/router/app_router.dart';
import 'package:e_commerce_app/core/widgets/default_button.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/sync-functions.dart';
import 'package:e_commerce_app/localization/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(currentLanguage);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.text('home'),
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const LogoutRequested());
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
         Padding(padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 0),
         child: defaultElevatedButton(function: () => syncCommands(), text: t.text('sync_data'))),
         Expanded(child:  Padding(
           padding: const EdgeInsets.all(10),
           child: GridView.count(
             crossAxisCount: 3,
             padding: const EdgeInsets.all(8),
             crossAxisSpacing: 8,
             mainAxisSpacing: 8,
             children: [
               GestureDetector(
                   onTap: () => context.push(AppRouter.command),
                   child: CardHomeIcon(icon: Icons.add_shopping_cart, title: 'Order')
               ),

               GestureDetector(
                   onTap: () =>context.push(AppRouter.listVisits),
                   child: CardHomeIcon(icon: Icons.account_tree, title: t.text('visits'))
               ),

               GestureDetector(
                   onTap: () =>context.push(AppRouter.stock),
                   child: CardHomeIcon(icon: Icons.add_chart_outlined, title: t.text('Stock'))
               ),
             ],
           ),
         )),
        ],
      )
    );
  }
}
