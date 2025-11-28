import 'package:e_commerce_app/core/di/injection.dart';
import 'package:e_commerce_app/core/router/app_router.dart';
import 'package:e_commerce_app/core/shared/colors.dart';
import 'package:e_commerce_app/core/shared/Loading/easy_loading.dart';
import 'package:e_commerce_app/database/ecommerce_database.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  // Initialize database before running app
  await ECommerceDatabase.instance.database;
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(const AuthCheckRequested()),
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();
          final router = AppRouter.createRouter(authBloc);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'E-Commerce-App',
            theme: ThemeData(
                primaryColor: ColorFile.appColor
            ),
            // theme: AppTheme.lightTheme(context),
            routerConfig: router,
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
