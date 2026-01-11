import 'package:e_commerce_app/core/screens/error_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/home/home_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:e_commerce_app/core/router/go_router_refresh_stream.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_bloc.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/detail_command_lines_product_screen.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/detail_visit_screen.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/list-visit-screen.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/list_clients_by_visitId.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/screens/list_stock_by_visitId.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/screens/command_detail_screen.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/screens/command_line_screen.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/screens/command_screen.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/stock_bloc.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/screens/stock_line_screen.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/screens/stock_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AppRouter {
  static const String home = '/';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String details = '/details';

  static const String command = '/command';
  static const String commandLine = '/commandLine';
  static const String detailCommand = '/detailCommand';

  // routes visites
  static const String listVisits = '/listVisits';
  static const String detailVisits = '/detailVisits';
  static const String detailCommandLine = '/detailCommandLine';
  static const String detailClientVisit = '/detailClientVisit';
  static const String detailStockVisit = '/detailStockVisit';

  // routes stock
  static const String stock = '/stock';
  static const String stockLine = '/stockLine';


  static GoRouter createRouter(AuthBloc authBloc) {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: home,

      // 👇 This allows GoRouter to rebuild on AuthBloc state change
      refreshListenable: GoRouterRefreshStream(authBloc.stream),

      errorBuilder: (context, state) => ErrorScreen(error: state.error),

      redirect: (context, state) {
        final authState = authBloc.state;
        final isLoggingIn = state.matchedLocation == login;

        if (authState is AuthUnauthenticated && !isLoggingIn) {
          return login;
        }

        if (authState is AuthAuthenticated && isLoggingIn) {
          return home;
        }

        return null; // no redirect
      },

      routes: [
        GoRoute(
          path: login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: profile,
          name: 'profile',
          builder: (context, state) => const ErrorScreen(),
        ),
        GoRoute(
          path: settings,
          name: 'settings',
          builder: (context, state) => const ErrorScreen(),
        ),
        // commands Routers
        GoRoute(
          path: command,
          name: 'Command',
          builder: (context, state) => CommandScreenProvider(),
        ),
        GoRoute(
          path: '/commandLine/:id',
          name: AppRouter.commandLine,
          builder: (context, state) {
            final commandId = state.pathParameters['id'];
            return CommandLineScreen(commandId: commandId!);
          },
        ),
        GoRoute(
          path: '/detailCommand/:id',
          name: AppRouter.detailCommand,
          builder: (context, state) {
            final commandId = state.pathParameters['id'];
            return CommandDetailScreen(commandId: commandId!);
          },
        ),

        GoRoute(
          path: AppRouter.listVisits,
          builder: (context, state) {
            return BlocProvider(
              create: (_) => VisitsBloc()..GetAllVisitsForUser(
                visitDate: DateFormat("dd/MM/yyyy").format(DateTime.now()),
              ),
              child: ListVisitScreen(),
            );
          },
        ),

        GoRoute(
          path: '/detailVisits/:id',
          name: AppRouter.detailVisits,
          builder: (context, state) {
            final visitId = state.pathParameters['id'];
            return DetailVisitScreen(visitId: visitId!);
          },
        ),

        GoRoute(
          path: '/detailCommandLine/:id/:clientName',
          name: AppRouter.detailCommandLine,
          builder: (context, state) {
            final commandId = state.pathParameters['id'] ?? '';
            final clientName = state.pathParameters['clientName'] ?? '';
            return DetailCommandLinesProductScreen(commandId: commandId, clientName: clientName);
          },
        ),

        GoRoute(
          path: '/detailClientVisit/:id',
          name: AppRouter.detailClientVisit,
          builder: (context, state) {
            final visitPlanId = state.pathParameters['id'];
            return ListClientsByVisitid(visitPlanId: visitPlanId!);
          },
        ),

        GoRoute(
          path: '/detailStockVisit/:id',
          name: AppRouter.detailStockVisit,
          builder: (context, state) {
            final visitId = state.pathParameters['id'];
            return ListStockByVisitid(visitId: visitId!);
          },
        ),

        // stock

        GoRoute(
          path: '/stock',
          builder: (context, state) {
            return BlocProvider(
              create: (_) => StockBloc()
                ..getVisitByDate()
                ..getListOfStocks(),
              child: StockScreen(),
            );
          },
        ),

        GoRoute(
          path: '/stockLine/:id',
          name: AppRouter.stockLine,
          builder: (context, state) {
            final stockId = state.pathParameters['id'];
            return StockLineScreen(stockId: stockId!);
          },
        ),
      ],
    );
  }
}
