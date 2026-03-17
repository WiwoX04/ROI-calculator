import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roi_calculator/features/calculator/presentation/calculator_screen.dart';
import 'package:roi_calculator/features/calculator/presentation/result_screen.dart'
    as presentation;
import 'package:roi_calculator/features/finish/presentation/finish_screen.dart';
import 'package:roi_calculator/features/insights/presentation/insights_screen.dart';
import 'package:roi_calculator/features/start/presentation/start_screen.dart';
import 'package:roi_calculator/models/roi_result_model.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const StartScreen();
      },
    ),
    GoRoute(
      path: '/calculator',
      builder: (context, state) {
        // Pomocnicza funkcja do bezpiecznego parsowania
        double? parseDouble(String key) {
          final val = state.uri.queryParameters[key];
          return (val != null) ? double.tryParse(val) : null;
        }

        return CalculatorScreen(
          selectedIndustry: state.uri.queryParameters['industry'] ?? 'General',

          // Podstawowe dane
          yearlyRevenue: parseDouble('yearlyRevenue'),
          avgOrderValue: parseDouble('avgOrderValue'),

          // Udziały (Shares)
          phoneShare: parseDouble('phoneShare'),
          mailShare: parseDouble('mailShare'),
          inPersonShare: parseDouble('inPersonShare'),
          ecommerceShare: parseDouble('ecommerceShare'),

          // Koszty (jeśli używasz)
          phoneCost: parseDouble('phoneCost'),
          mailCost: parseDouble('mailCost'),
          inPersonCost: parseDouble('inPersonCost'),
          ecommerceCost: parseDouble('ecommerceCost'),
          mobileCost: parseDouble('mobileCost'),

          // Migracja
          phoneMigration: parseDouble('phoneMigration'),
          mailMigration: parseDouble('mailMigration'),
          personalMigration: parseDouble('personalMigration'),
          ecommerceMigration: parseDouble('ecommerceMigration'),

          // Finanse i błędy
          salesGrowth: parseDouble('salesGrowth'),
          grossMargin: parseDouble('grossMargin'),
          errorRate: parseDouble('errorRate'),
          ecommerceRate: parseDouble('ecommerceRate'),
          errorCost: parseDouble('errorCost'),

          // Inwestycja
          capex: parseDouble('capex'),
          opex: parseDouble('opex'),
        );
      },
    ),
    GoRoute(
      path: "/results",
      builder: (BuildContext context, GoRouterState state) {
        final selectedIndustry =
            state.uri.queryParameters['selectedIndustry'] ?? '';
        final roi = double.parse(state.uri.queryParameters['roi'] ?? '0');
        final benefit = double.parse(
          state.uri.queryParameters['benefit'] ?? '0',
        );
        final marginIncrease = double.parse(
          state.uri.queryParameters['marginIncrease'] ?? '0',
        );
        final roitime = double.parse(
          state.uri.queryParameters['roitime'] ?? '0',
        );
        final esavings = double.parse(
          state.uri.queryParameters['esavings'] ?? '0',
        );
        final msavings = double.parse(
          state.uri.queryParameters['msavings'] ?? '0',
        );
        final yearlyRevenue =
            double.tryParse(
              state.uri.queryParameters['yearlyRevenue'] ?? '0',
            ) ??
            0;

        final avgOrderValue =
            double.tryParse(
              state.uri.queryParameters['avgOrderValue'] ?? '0',
            ) ??
            0;

        final phoneShare =
            double.tryParse(state.uri.queryParameters['phoneShare'] ?? '0') ??
            0;

        final mailShare =
            double.tryParse(state.uri.queryParameters['mailShare'] ?? '0') ?? 0;

        final inPersonShare =
            double.tryParse(
              state.uri.queryParameters['inPersonShare'] ?? '0',
            ) ??
            0;

        final ecommerceShare =
            double.tryParse(
              state.uri.queryParameters['ecommerceShare'] ?? '0',
            ) ??
            0;

        final phoneCost =
            double.tryParse(state.uri.queryParameters['phoneCost'] ?? '0') ?? 0;

        final mailCost =
            double.tryParse(state.uri.queryParameters['mailCost'] ?? '0') ?? 0;

        final inPersonCost =
            double.tryParse(state.uri.queryParameters['inPersonCost'] ?? '0') ??
            0;

        final ecommerceCost =
            double.tryParse(
              state.uri.queryParameters['ecommerceCost'] ?? '0',
            ) ??
            0;

        final mobileCost =
            double.tryParse(state.uri.queryParameters['mobileCost'] ?? '0') ??
            0;

        final phoneMigration =
            double.tryParse(
              state.uri.queryParameters['phoneMigration'] ?? '0',
            ) ??
            0;

        final mailMigration =
            double.tryParse(
              state.uri.queryParameters['mailMigration'] ?? '0',
            ) ??
            0;

        final personalMigration =
            double.tryParse(
              state.uri.queryParameters['personalMigration'] ?? '0',
            ) ??
            0;

        final ecommerceMigration =
            double.tryParse(
              state.uri.queryParameters['ecommerceMigration'] ?? '0',
            ) ??
            0;

        final salesGrowth =
            double.tryParse(state.uri.queryParameters['salesGrowth'] ?? '0') ??
            0;

        final grossMargin =
            double.tryParse(state.uri.queryParameters['grossMargin'] ?? '0') ??
            0;

        final errorRate =
            double.tryParse(state.uri.queryParameters['errorRate'] ?? '0') ?? 0;

        final ecommerceRate =
            double.tryParse(
              state.uri.queryParameters['ecommerceRate'] ?? '0',
            ) ??
            0;

        final errorCost =
            double.tryParse(state.uri.queryParameters['errorCost'] ?? '0') ?? 0;

        final capex =
            double.tryParse(state.uri.queryParameters['capex'] ?? '0') ?? 0;

        final opex =
            double.tryParse(state.uri.queryParameters['opex'] ?? '0') ?? 0;

        return presentation.ResultScreen(
          roi: roi,
          benefit: benefit,
          marginIncrease: marginIncrease,
          roitime: roitime,
          esavings: esavings,
          msavings: msavings,
          selectedIndustry: selectedIndustry,
          yearlyRevenue: yearlyRevenue,
          avgOrderValue: avgOrderValue,

          phoneShare: phoneShare,
          mailShare: mailShare,
          inPersonShare: inPersonShare,
          ecommerceShare: ecommerceShare,

          phoneCost: phoneCost,
          mailCost: mailCost,
          inPersonCost: inPersonCost,
          ecommerceCost: ecommerceCost,
          mobileCost: mobileCost,

          phoneMigration: phoneMigration,
          mailMigration: mailMigration,
          personalMigration: personalMigration,
          ecommerceMigration: ecommerceMigration,

          salesGrowth: salesGrowth,
          grossMargin: grossMargin,

          errorRate: errorRate,
          ecommerceRate: ecommerceRate,
          errorCost: errorCost,

          capex: capex,
          opex: opex,
        );
      },
    ),
    GoRoute(
      path: "/finish",
      builder: (BuildContext context, GoRouterState state) {
        final selectedIndustry =
            state.uri.queryParameters['selectedIndustry'] ?? '';
        final roi = double.parse(state.uri.queryParameters['roi'] ?? '0');
        final benefit = double.parse(
          state.uri.queryParameters['benefit'] ?? '0',
        );
        final marginIncrease = double.parse(
          state.uri.queryParameters['marginIncrease'] ?? '0',
        );
        final roitime = double.parse(
          state.uri.queryParameters['roitime'] ?? '0',
        );
        final esavings = double.parse(
          state.uri.queryParameters['esavings'] ?? '0',
        );
        final msavings = double.parse(
          state.uri.queryParameters['msavings'] ?? '0',
        );
        return FinishScreen(
          roi: roi,
          benefit: benefit,
          marginIncrease: marginIncrease,
          roitime: roitime,
          esavings: esavings,
          msavings: msavings,
          selectedIndustry: selectedIndustry,
        );
      },
    ),
    GoRoute(
      path: "/insights",
      builder: (BuildContext context, GoRouterState state) {
        final selectedIndustry =
            state.uri.queryParameters['selectedIndustry'] ?? '';
        final roi = double.parse(state.uri.queryParameters['roi'] ?? '0');
        final benefit = double.parse(
          state.uri.queryParameters['benefit'] ?? '0',
        );
        final marginIncrease = double.parse(
          state.uri.queryParameters['marginIncrease'] ?? '0',
        );
        final roitime = double.parse(
          state.uri.queryParameters['roitime'] ?? '0',
        );
        final esavings = double.parse(
          state.uri.queryParameters['esavings'] ?? '0',
        );
        final msavings = double.parse(
          state.uri.queryParameters['msavings'] ?? '0',
        );
        return InsightsScreen(
          roi: roi,
          benefit: benefit,
          marginIncrease: marginIncrease,
          roitime: roitime,
          esavings: esavings,
          msavings: msavings,
          selectedIndustry: selectedIndustry,
        );
      },
    ),
  ],
);
