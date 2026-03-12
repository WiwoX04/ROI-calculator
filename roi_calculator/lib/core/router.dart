import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roi_calculator/features/calculator/presentation/calculator_screen.dart';
import 'package:roi_calculator/features/calculator/presentation/result.screen.dart';
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
      path: "/calculator",
      builder: (BuildContext context, GoRouterState state) {
        final selectedIndustry = state.uri.queryParameters['selectedIndustry'];
        return CalculatorScreen(selectedIndustry: selectedIndustry);
      },
    ),
    GoRoute(
      path: "/results",
      builder: (BuildContext context, GoRouterState state) {
        final selectedIndustry = state.uri.queryParameters['selectedIndustry'];
        final roi = double.parse(state.uri.queryParameters['roi'] ?? '0');
        final benefit = double.parse(
          state.uri.queryParameters['benefit'] ?? '0',
        );
        final cost = double.parse(state.uri.queryParameters['cost'] ?? '0');
        final orders = double.parse(state.uri.queryParameters['orders'] ?? '0');
        final esavings = double.parse(
          state.uri.queryParameters['esavings'] ?? '0',
        );
        final msavings = double.parse(
          state.uri.queryParameters['msavings'] ?? '0',
        );
        final profit = double.parse(state.uri.queryParameters['profit'] ?? '0');
        return ResultScreen(
          roi: roi,
          benefit: benefit,
          cost: cost,
          orders: orders,
          esavings: esavings,
          msavings: msavings,
          profit: profit,
        );
      },
    ),
    GoRoute(
      path: "/finish",
      builder: (BuildContext context, GoRouterState state) {
        return const FinishScreen();
      },
    ),
    GoRoute(
      path: "/insights",
      builder: (BuildContext context, GoRouterState state) {
        return const InsightsScreen();
      },
    ),
  ],
);
